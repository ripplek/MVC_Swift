//
//  BaseViewController.swift
//  conjoined_hospital
//
//  Created by 张坤 on 2017/7/21.
//  Copyright © 2017年 searainbow. All rights reserved.
//

import UIKit

class BaseViewController: UIViewController {

    override func viewDidLoad() {
        super.viewDidLoad()

        // Do any additional setup after loading the view.
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
    deinit {
        printLog("deinit--",self.description)
    }

}
