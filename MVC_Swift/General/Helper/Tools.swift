//
//  Tools.swift
//  MVC_Swift
//
//  Created by 张坤 on 2017/7/12.
//  Copyright © 2017年 zhangkun. All rights reserved.
//

import UIKit

/// ScreenWidth
let SCREEN_WIDTH = UIScreen.main.bounds.size.width

/// ScreenHeight
let SCREEN_HEIGHT = UIScreen.main.bounds.size.height

//MARK: - customTools

/// 找到view所在的controller
///
/// - Parameter view: view
/// - Returns: controller
func findViewController(view: UIView?) -> UIViewController {
    if view == nil {
        return (UIApplication.shared.keyWindow?.rootViewController?.childViewControllers.first)!;
    } else {
        var target: UIResponder? = view!
        while target != nil {
            target = target!.next
            if target is UIViewController {
                return target as! UIViewController
            }
        }
    }
    return (UIApplication.shared.keyWindow?.rootViewController?.childViewControllers.first)!;
}

/// 线程锁，相当于Objective-C中的@synchronized
///
/// - Parameters:
///   - lock: 需要加锁的变量
///   - closure: 执行加锁code的闭包
func synchronized(_ lock: AnyObject, closure: ()->()) {
    objc_sync_enter(lock)
    closure()
    objc_sync_exit(lock)
}

typealias myTask = (_ cancel: Bool)->()
/// 延时执行函数
///
/// - Parameters:
///   - time: 延时时长
///   - task: 要执行的闭包
/// - Returns: 可取消的可执行闭包
@discardableResult
func dealy(_ time: TimeInterval, task:@escaping ()->()) -> myTask? {
    
    func dispatch_later(closure:@escaping ()->()) {
        DispatchQueue.main.asyncAfter(deadline: DispatchTime.now() + time, execute: closure)
    }
    
    var closure: (()->())? = task
    var result: myTask?
    let dealyedClosure: myTask = {
        cancel in
        if let closure = closure {
            if cancel == false {
                closure()
            }
        }
        closure = nil
        result = nil
    }
    
    result = dealyedClosure
    
    dispatch_later {
        dealyedClosure(false)
    }
    
    return result
}

/// 区间随机数生成器
///
/// - Parameter range: 随机数生成区间
/// - Returns: 区间内随机数
func random(in range: Range<Int>) -> Int {
    let count = UInt32(range.upperBound - range.lowerBound)
    return Int(arc4random_uniform(count)) + range.lowerBound
}

extension Int {
    /// 便利循环器
    func times(f: ()->()) {
        for _ in 1...self {
            f()
        }
    }
}

/// Debug输出
func printLog<T>(_ message: T..., file: String = #file, method: String = #function, line: Int = #line) {
    #if DEBUG
        print("\((file as NSString).lastPathComponent)[\(line)],\(method):\(message)")
    #endif
}

/// 日期格式化
let timeFormatter: DateFormatter = {
    let formatter = DateFormatter()
    formatter.dateFormat = "YYYY-MM-dd"
    return formatter
}()


/// 适配iOS 11 取消automaticallyAdjustsScrollViewInsets
///
/// - Parameters:
///   - controller: UIViewController
///   - view: UIScrollView
func adjustsScrollViewInsetNever(_ controller: UIViewController, _ view: UIScrollView) {
    if #available(iOS 11.0, *) {
        view.contentInsetAdjustmentBehavior = .never
    } else {
        controller.automaticallyAdjustsScrollViewInsets = false
    }
}

