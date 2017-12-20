//
//  ReactiveTableViewCell.swift
//  conjoined_hospital
//
//  Created by 张坤 on 2017/7/27.
//  Copyright © 2017年 searainbow. All rights reserved.
//

import UIKit
import RxSwift

class ReactiveTableViewCell: UITableViewCell {
    
    public private(set) var reuseDisposeBag = DisposeBag()
    
    open override func prepareForReuse() {
        super.prepareForReuse()
        reuseDisposeBag = DisposeBag()
    }
    
}
