//
//  Frame.swift
//  MVC_Swift
//
//  Created by 张坤 on 2017/7/12.
//  Copyright © 2017年 zhangkun. All rights reserved.
//

import UIKit

import UIKit

extension UIView {
    
    var x: CGFloat {
        get {
            return self.frame.origin.x
        }
        set {
            self.x = newValue
        }
    }
    
    var y: CGFloat {
        get {
            return self.frame.origin.y
        }
        set {
            self.y = newValue
        }
    }
    
    var width: CGFloat {
        get {
            return self.frame.size.width
        }
        set {
            self.width = newValue
        }
    }
    
    var height: CGFloat {
        get {
            return self.frame.size.height
        }
        set {
            self.height = newValue
        }
    }
    
    var centerX: CGFloat {
        get {
            return self.center.x
        }
        set {
            self.centerX = newValue
        }
    }
    
    var ceneterY: CGFloat {
        get {
            return self.center.y
        }
        set {
            self.ceneterY = newValue
        }
    }
    
    var maxX: CGFloat {
        get {
            return self.x + self.width
        }
    }
    
    var maxY: CGFloat {
        get {
            return self.y + self.height
        }
    }
}
