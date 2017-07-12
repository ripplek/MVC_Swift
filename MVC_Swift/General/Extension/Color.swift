//
//  Color.swift
//  MVC_Swift
//
//  Created by 张坤 on 2017/7/12.
//  Copyright © 2017年 zhangkun. All rights reserved.
//

import UIKit

extension Int {
    var color: UIColor {
        let red = CGFloat((self & 0xff0000) >> 16) / 255.0
        let green = CGFloat((self & 0x00ff00) >> 8) / 255.0
        let blue = CGFloat(self & 0x0000ff) / 255.0
        
        return UIColor(red: red, green: green, blue: blue, alpha: 1)
    }
}
