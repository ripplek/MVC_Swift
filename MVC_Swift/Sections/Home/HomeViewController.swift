//
//  HomeViewController.swift
//  MVC_Swift
//
//  Created by 张坤 on 2017/7/12.
//  Copyright © 2017年 zhangkun. All rights reserved.
//

import UIKit
import RxSwift
import RxCocoa
import RxDataSources
import ESPullToRefresh
import Moya
import Kingfisher
import NSObject_Rx

class HomeViewController: BaseViewController {
    typealias Section = SectionModel<Void, KnowledgeDetailContentModel>
    // MARK: - @IBOutlet
    @IBOutlet weak var tableView: UITableView!

    // MARK: - @properties
    
    // MARK: - @override
    override func viewDidLoad() {
        super.viewDidLoad()
        title = "首页"
        prepareUI()
        prepareTableView()
        addRefresh()
        requestAPI()
    }
    // MARK: - @func
    
    // MARK: - @private properties
    private let knowledgeList = Variable<[KnowledgeDetailContentModel]>([])
    private let provider = OnlineProvider<HomeAPI>()
    private var currentPage = 1
    
    // MARK: - @private func
    private func addRefresh() {
        self.tableView.es.addPullToRefresh {
            [weak self] in
            /// 在这里做刷新相关事件
            self?.currentPage = 1
            self?.requestAPI()
        }
        
        self.tableView.es.addInfiniteScrolling {
            [weak self] in
            /// 在这里做加载更多相关事件
            self?.currentPage += 1
            self?.moreRequestAPI()
        }
    }
    
    /// 下拉刷新
    private func requestAPI() {
        provider
            .request(HomeAPI.KnowledgeList(currentPage: currentPage, pageSize: pageSize))
            .filterSuccessfulStatusCodes()
            .mapJSON()
            .mapObject(type: KnowledgeModel.self)
            .subscribe(onNext: { [weak self] (model) in
                guard let `self` = self else { return }
                if let data = model.data {
                    self.knowledgeList.value = data.data
                    /// 如果你的刷新事件成功，设置completion自动重置footer的状态
                    self.tableView.es.stopPullToRefresh(ignoreDate: true)
                    self.tableView.es.resetNoMoreData()
                }
            }).disposed(by: rx.disposeBag)
    }
    
    /// 上拉加载更多
    private func moreRequestAPI() {
        provider
            .request(HomeAPI.KnowledgeList(currentPage: currentPage, pageSize: pageSize))
            .filterSuccessfulStatusCodes()
            .mapJSON()
            .mapObject(type: KnowledgeModel.self)
            .subscribe(onNext: { [weak self] (model) in
                guard let `self` = self else { return }
                if let data = model.data {
                    guard data.data.count > 0 else {
                        /// 通过es_noticeNoMoreData()设置footer暂无数据状态
                        self.tableView.es.noticeNoMoreData()
                        return
                    }
                    self.knowledgeList.value += data.data
                    /// 如果你的加载更多事件成功，调用es_stopLoadingMore()重置footer状态
                    self.tableView.es.stopLoadingMore()
                }
            }).disposed(by: rx.disposeBag)
    }
    
    private func prepareTableView() {
        tableView.rowHeight = KnowledgeCell.rowheight
        
        let dataSource = RxTableViewSectionedReloadDataSource<Section>(configureCell: { dataSource, tableView, indexPath, element in
            let cell = tableView.dequeueReusableCell(withIdentifier: R.reuseIdentifier.knowledgeCell, for: indexPath)!
            cell.imgV.kf.setImage(with: URL(string: element.imgUrl1))
            cell.titleLabel.text = element.title
            cell.detailLabel.text = element.contentString
            cell.selectionStyle = .none
            return cell
        })
        
        knowledgeList.asDriver()
            .map({ [Section(model: (), items: $0)] })
            .drive(tableView.rx.items(dataSource: dataSource))
            .disposed(by: rx.disposeBag)
        
        tableView.rx.modelSelected(KnowledgeDetailContentModel.self).subscribe(onNext: { [weak self] (model) in
//            guard let `self` = self else { return }
//            let detailVC = R.storyboard.knowledge.knowledgeDetailViewController()!
//            detailVC.id = model.id
//            self.navigationController?.pushViewController(detailVC, animated: true)
        }).disposed(by: rx.disposeBag)
    }
    
    private func prepareUI() {
        view.backgroundColor = UIColor.white
        tableView.tableFooterView = UIView()
    }

}
