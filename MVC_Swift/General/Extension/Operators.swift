//
//  Operators.swift
//  MVC_Swift
//
//  Created by 张坤 on 2017/12/13.
//  Copyright © 2017年 zhangkun. All rights reserved.
//

import Foundation

// 强制解包debug
infix operator !!: NilCoalescingPrecedence
/// 正则匹配
infix operator =~: MatchPrecedence

/// 正则匹配
struct RegexHelper {
    let regex: NSRegularExpression
    
    init(_ pattern: String) throws {
        try regex = NSRegularExpression(pattern: pattern,
                                        options: .caseInsensitive)
    }
    
    func match(_ input: String) -> Bool {
        let matches = regex.matches(in: input,
                                    options: [],
                                    range: NSMakeRange(0, input.utf16.count))
        return matches.count > 0
    }
}

precedencegroup MatchPrecedence {
    associativity: none
    higherThan: DefaultPrecedence
}

func =~(lhs: String, rhs: String) -> Bool {
    do {
        return try RegexHelper(rhs).match(lhs)
    } catch _ {
        return false
    }
}


extension Optional {
    /// Performs a forced unwrap operation, returning
    /// the wrapped value of an `Optional` instance
    /// or performing a `fatalError` with the string
    /// on the rhs of the operator.
    ///
    /// Forced unwrapping unwraps the left-hand side
    /// if it has a value or errors if it does not.
    /// The result of a successful operation will
    /// be the same type as the wrapped value of its
    /// left-hand side argument.
    ///
    /// This operator uses short-circuit evaluation:
    /// The `optional` lhs is checked first, and the
    /// `fatalError` is called only if the left hand
    /// side is nil. For example:
    ///
    ///    guard !lastItem.isEmpty else { return }
    ///    let lastItem = array.last !! "Array guaranteed to be non-empty because..."
    ///
    ///    let willFail = [].last !! "Array should have been guaranteed to be non-empty because..."
    ///
    ///
    /// In this example, `lastItem` is assigned the last value
    /// in `array` because the array is guaranteed to be non-empty.
    /// `willFail` is never assigned as the last item in an empty array is nil.
    /// - Parameters:
    ///   - optional: An optional value.
    ///   - message: A message to emit via `fatalError` after
    ///     failing to unwrap the optional.
    public static func !!(optional: Optional, errorMessage: @autoclosure () -> String) -> Wrapped {
        if let value = optional { return value }
        fatalError(errorMessage())
    }
}


