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

extension UIColor {
    static var selected: UIColor {
        return 0x0fbf79.color
    }
    
    static var normal: UIColor {
        return 0x747474.color
    }
    
    static var placeholder: UIColor {
        return 0xcccccc.color
    }
    
    static var barTint: UIColor {
        return 0x03cea4.color
    }
    
    static var tab: UIColor {
        return 0xf6f6f6.color
    }
    
    static var tableBg: UIColor {
        return 0xf8f9fc.color
    }
    
    static var success: UIColor {
        return 0x44f614.color
    }
    
    static var failed: UIColor {
        return 0xf62414.color
    }
    
    static var board: UIColor {
        return 0xe5e5e5.color
    }
    
    static var randomColor: UIColor {
        let colorArr = [0x72d474.color, 0x1bd2f3.color, 0x49a7fe.color, 0xff9a9a.color, 0xfed999.color]
        return colorArr[random(in: 0..<colorArr.count)]
    }
}
