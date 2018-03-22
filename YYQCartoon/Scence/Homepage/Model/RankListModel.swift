//
//  RankListModel.swift
//  YYQCartoon
//
//  Created by kcl on 2018/3/21.
//  Copyright © 2018年 KCL. All rights reserved.
//

import Foundation
import ObjectMapper

struct RankListModel {
    var code:NSNumber?
    var data:RankList?
}
struct RankList {
    var stateCode:NSNumber?
    var message:String?
    var returnData:RankListData?
}
struct RankListData {

    var rankinglist:[Rank]?
}
struct Rank {

    var title:String?
    var subTitle:String?
    var cover:String?
    var argName:String?
    var argValue:String?
    var rankingType:String?

}
extension RankListModel: Mappable {

    init?(map: Map) {
        
    }
    mutating func mapping(map: Map) {
        data <- map["data"]
        code <- map["code"]
    }
}
extension RankList: Mappable {

    init?(map: Map) {

    }
    mutating func mapping(map: Map) {
        stateCode <- map["code"]
        message <- map["message"]
        returnData <- map["returnData"]
    }
}
extension RankListData: Mappable {

    init?(map: Map) {

    }
    mutating func mapping(map: Map) {
        rankinglist <- map["rankinglist"]
    }
}
extension Rank: Mappable {

    init?(map: Map) {

    }
    mutating func mapping(map: Map) {
        
        title <- map["title"]
        subTitle <- map["subTitle"]
        cover <- map["cover"]
        argName <- map["argName"]
        argValue <- map["argValue"]
        rankingType <- map["rankingType"]
    }
}
