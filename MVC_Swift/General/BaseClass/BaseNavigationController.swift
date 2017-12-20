//
//  BaseNavigationController.swift
//  conjoined_hospital
//
//  Created by 张坤 on 2017/7/28.
//  Copyright © 2017年 searainbow. All rights reserved.
//

import UIKit

class BaseNavigationController: UINavigationController {
    

    override func viewDidLoad() {
        super.viewDidLoad()
        
        self.navigationBar.isTranslucent = false
//        let navigationBar = UINavigationBar.appearance()
//        navigationBar.tintColor = UIColor.white
//        navigationBar.barTintColor = UIColor.barTint
//        navigationBar.titleTextAttributes = [NSAttributedStringKey.foregroundColor : UIColor.white]
//        navigationBar.backIndicatorImage = R.image.nav_back()
//        navigationBar.backIndicatorTransitionMaskImage = R.image.nav_back()
    }
    
    override func pushViewController(_ viewController: UIViewController, animated: Bool) {
        viewController.navigationItem.backBarButtonItem = UIBarButtonItem(image: nil, style: .plain, target: nil, action: nil)
        
        if self.viewControllers.count > 0 {
            viewController.hidesBottomBarWhenPushed = true
        }
        super.pushViewController(viewController, animated: true)
    }


}
