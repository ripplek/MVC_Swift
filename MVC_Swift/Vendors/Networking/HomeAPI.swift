//
//  HomeAPI.swift
//  MVC_Swift
//
//  Created by 张坤 on 2017/12/13.
//  Copyright © 2017年 zhangkun. All rights reserved.
//

import Foundation
import Moya

enum HomeAPI {
    case KnowledgeList(currentPage: Int, pageSize: Int)
}

extension HomeAPI: TargetType {
    var headers: [String : String]? {
        return nil
    }
    
    /// The target's base `URL`.
    var baseURL: URL {
        return hostURL
    }
    
    /// The path to be appended to `baseURL` to form the full `URL`.
    var path: String {
        switch self {
        case .KnowledgeList:
            return "/healthActivity/queryHealthActivityList.do"
            
        }
    }
    
    /// The HTTP method used in the request.
    var method: Moya.Method {
        return .post
    }
    
    /// The parameters to be encoded in the request.
    var parameters: [String : Any]? {
        switch self {
        case .KnowledgeList(let currentPage, let pageSize):
            return ["currentPage" : currentPage, "pageSize" : pageSize]
        }
    }
    
    /// The method used for parameter encoding.
    var parameterEncoding: ParameterEncoding {
        //        return JSONEncoding.default
        return URLEncoding.default
    }
    
    /// The type of HTTP task to be performed.
    var task: Task {
        if let requestParameters = parameters {
            return .requestParameters(parameters: requestParameters, encoding: parameterEncoding)
        }
        
        return .requestPlain
    }
    
    /// Provides stub data for use in testing.
    var sampleData: Data {
        return Data()
    }
    
}
