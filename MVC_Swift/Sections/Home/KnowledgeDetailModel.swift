//
//  KnowledgeDetailModel.swift
//  conjoined_hospital
//
//  Created by 张坤 on 2017/8/1.
//  Copyright © 2017年 searainbow. All rights reserved.
//

import UIKit
import ObjectMapper

class KnowledgeModel: Mappable {
    var code = -1
    var data: KnowledgeListModel?
    
    required init?(map: Map) {
    }
    
    func mapping(map: Map) {
        code <- map["code"]
        data <- map["data"]
    }
}

class KnowledgeListModel: Mappable {
    var currentPage = -1
    var pageSize = -1
    var data: [KnowledgeDetailContentModel] = []
    var total = 0
    
    required init?(map: Map) {
    }
    
    func mapping(map: Map) {
        currentPage <- map["currentPage"]
        pageSize <- map["pageSize"]
        data <- map["data"]
        total <- map["total"]
    }
}

class KnowledgeDetailContentModel: Mappable {
    var content = ""
    var contentString = ""
    var createTime = ""
    var createTimeStr = ""
    var id = -1
    var imgUrl = ""
    var imgUrl1 = ""
    var title = ""
    var type = -1
    
    required init?(map: Map) {
    }
    
    func mapping(map: Map) {
        content <- map["content"]
        contentString <- map["contentString"]
        createTime <- map["createTime"]
        createTimeStr <- map["createTimeStr"]
        id <- map["id"]
        imgUrl <- map["imgUrl"]
        imgUrl1 <- map["imgUrl1"]
        title <- map["title"]
        type <- map["type"]
    }
}

class KnowledgeDetailModel: Mappable {
    var code = -1
    var data: KnowledgeDetailContentModel?
    
    required init?(map: Map) {
    }
    
    func mapping(map: Map) {
        code <- map["code"]
        data <- map["data"]
    }
}
