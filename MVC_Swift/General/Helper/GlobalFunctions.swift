//
//  GlobalFunctions.swift
//  conjoined_hospital
//
//  Created by 张坤 on 2017/7/25.
//  Copyright © 2017年 searainbow. All rights reserved.
//

import Foundation
import RxSwift
import Reachability

// Ideally a Pod. For now a file.
func delayToMainThread(_ delay:Double, closure:@escaping ()->()) {
    DispatchQueue.main.asyncAfter (
        deadline: DispatchTime.now() + Double(Int64(delay * Double(NSEC_PER_SEC))) / Double(NSEC_PER_SEC), execute: closure)
}

func logPath() -> URL {
    let docs = FileManager.default.urls(for: .documentDirectory, in: .userDomainMask).last!
    return docs.appendingPathComponent("logger.txt")
}

//let logger = Logger(destination: logPath())

private let reachabilityManager = ReachabilityManager()

// An observable that completes when the app gets online (possibly completes immediately).
func connectedToInternetOrStubbing() -> Observable<Bool> {
    return reachabilityManager?.reach ?? Observable.just(false)
}

private class ReachabilityManager {
    
    private let reachability: Reachability
    
    let _reach = ReplaySubject<Bool>.create(bufferSize: 1)
    var reach: Observable<Bool> {
        return _reach.asObservable()
    }
    
    init?() {
        guard let r = Reachability() else {
            return nil
        }
        self.reachability = r
        
        do {
            try self.reachability.startNotifier()
        } catch {
            return nil
        }
        
        self._reach.onNext(self.reachability.connection != .none)
        
        self.reachability.whenReachable = { _ in
            DispatchQueue.main.async { self._reach.onNext(true) }
        }
        
        self.reachability.whenUnreachable = { _ in
            DispatchQueue.main.async { self._reach.onNext(false) }
        }
    }
    
    deinit {
        reachability.stopNotifier()
    }
}

