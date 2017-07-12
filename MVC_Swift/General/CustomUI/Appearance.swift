//
//  Appearance.swift
//  MVC_Swift
//
//  Created by 张坤 on 2017/7/12.
//  Copyright © 2017年 zhangkun. All rights reserved.
//

import UIKit

struct Appearance {
    
    // MARK: Component Theming
    static func applyBottomLine(to view: UIView, color: UIColor = UIColor.black) {
        let line = UIView(frame: CGRect(x: 0, y: view.frame.height - 1, width: view.frame.width, height: 1))
        line.backgroundColor = color
        view.addSubview(line)
    }
    
}
