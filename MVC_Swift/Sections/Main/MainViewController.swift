//
//  MainViewController.swift
//  MVC_Swift
//
//  Created by 张坤 on 2017/7/12.
//  Copyright © 2017年 zhangkun. All rights reserved.
//

import UIKit
import SwiftyJSON

let kMenuItemController = "page"
let kMenuItemTitle = "title"
let kMenuItemNormalIcon = "normal_icon"
let kMenuItemNormalIconSelect = "normal_icon_select"

class MainViewController: UITabBarController {

    override func viewDidLoad() {
        super.viewDidLoad()
        initTab()
    }
    
    func initTab() {
        func loadMenuData() -> Array<Any> {
            let path = Bundle.main.path(forResource: "Menu", ofType: "json")
            do {
                let jsonData = try Data(contentsOf: URL(fileURLWithPath: path!))
                let json = JSON(data: jsonData)
                return json["tabbar_items"].arrayValue
            } catch let error {
                print(error)
            }
            return []
        }
        
        let tabbars = loadMenuData()
        var childControllers = Array<UIViewController>()
        
        for tabbar in tabbars {
            if let tabbar = tabbar as? JSON {
                let controllerString = tabbar[kMenuItemController].string!
                var namespace = Bundle.main.infoDictionary!["CFBundleExecutable"] as! String
                if namespace.contains("-") {
                    namespace = namespace.replacingOccurrences(of: "-", with: "_")
                }
                let controller = NSClassFromString(namespace + "." + controllerString) as! UIViewController.Type
                var navigationController: BaseNavigationController
                if controller is HomeViewController.Type {
                    navigationController = BaseNavigationController(rootViewController: R.storyboard.home.knowledgeViewController()!)
                } else {
                    navigationController = BaseNavigationController(rootViewController: controller.init())
                }
                let barItem = UITabBarItem(title: tabbar[kMenuItemTitle].string, image: UIImage(named: tabbar[kMenuItemNormalIcon].string!)?.withRenderingMode(.alwaysOriginal), selectedImage: UIImage(named: tabbar[kMenuItemNormalIconSelect].string!)?.withRenderingMode(.alwaysOriginal))
                barItem.setTitleTextAttributes([NSAttributedStringKey.foregroundColor : 0x101010.color], for: .normal)
                barItem.setTitleTextAttributes([NSAttributedStringKey.foregroundColor : 0xf04447.color], for: .selected)
                navigationController.tabBarItem = barItem
                childControllers.append(navigationController)
            }
        }
        
        self.viewControllers = childControllers
    }

}
