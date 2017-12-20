//
//  Networking.swift
//  conjoined_hospital
//
//  Created by 张坤 on 2017/7/25.
//  Copyright © 2017年 searainbow. All rights reserved.
//

import Foundation
import Moya
import RxSwift
import Alamofire

// MARK: - Default

let pageSize = 15

var hostURL: URL {
    get {
        #if DEBUG
            //            return URL(string: "http://172.25.14.112/web/")! // 测试
            //            return URL(string: "http://172.25.14.222:8080/web")!
//            return URL(string: "http://172.25.8.183:8080/web")! // q
            return URL(string: "http://210.51.183.103/web")!
        #else
            return URL(string: "http://210.51.183.103/web")!
        #endif
    }
}

class OnlineProvider<Target> where Target: Moya.TargetType {
    
    private let online: Observable<Bool>
    private let provider: MoyaProvider<Target>
    
    init(endpointClosure: @escaping MoyaProvider<Target>.EndpointClosure = MoyaProvider.defaultEndpointMapping,
         requestClosure: @escaping MoyaProvider<Target>.RequestClosure = Networking.endpointResolver(),
         stubClosure: @escaping MoyaProvider<Target>.StubClosure = MoyaProvider.neverStub,
         manager: Manager = MoyaProvider<Target>.defaultAlamofireManager(),
         plugins: [PluginType] = [],
         trackInflights: Bool = false,
         online: Observable<Bool> = connectedToInternetOrStubbing()) {
        
        self.online = online
        self.provider = MoyaProvider(endpointClosure: endpointClosure, requestClosure: requestClosure, stubClosure: stubClosure, manager: manager, plugins: plugins, trackInflights: trackInflights)
    }
    
    func request(_ token: Target) -> Observable<Moya.Response> {
        let actualRequest = provider.rx.request(token)
        return online
            .ignore(value: false)  // Wait until we're online
            .take(1)        // Take 1 to make sure we only invoke the API once.
            .flatMap { _ in // Turn the online state into a network request
                return actualRequest
        }
        
    }
}

// Custom Networking
struct Networking {
    
    static func endpointResolver<T>() -> MoyaProvider<T>.RequestClosure where T: TargetType {
        return { (endpoint, closure) in
            if var request = try? endpoint.urlRequest() {
                request.httpShouldHandleCookies = false
                request.timeoutInterval = 15
                closure(.success(request))
            }
        }
    }
    
    static var plugins: [PluginType] {
        return [NetworkLoggerPlugin()]
    }
}

//extension RxMoyaProvider {
//    func request(_ token: Target) -> Observable<Response> {
//        return request(token, callbackQueue: nil).asObservable()
//    }
//}

