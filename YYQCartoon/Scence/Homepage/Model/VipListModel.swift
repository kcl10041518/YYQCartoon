//
//  VipListModel.swift
//  YYQCartoon
//
//  Created by kcl on 2018/3/21.
//  Copyright © 2018年 KCL. All rights reserved.
//

import Foundation
import ObjectMapper

struct VipListModel {
    var code:NSNumber?
    var data:VipList?
}

struct VipList {
    var stateCode:NSNumber?
    var message:String?
    var returnData:VipListData?
}
struct VipListData {

    var newVipList:[Vip]?
}
struct Vip {

    var comics:[Comic]?
    var canMore:Bool?
    var argName:String?
    var argValue:String?
    var itemTitle:String?
    var titleIconUrl:String?
    var newTitleIconUrl:String?
    var maxSize:NSNumber?
    var description:String?


}
extension VipListModel: Mappable {

    init?(map: Map) {

    }

    mutating func mapping(map: Map) {
        data <- map["data"]
        code <- map["code"]
    }
}
extension VipList: Mappable {

    init?(map: Map) {

    }

    mutating func mapping(map: Map) {
        stateCode <- map["code"]
        message <- map["message"]
        returnData <- map["returnData"]
    }
}
extension VipListData: Mappable {

    init?(map: Map) {

    }

    mutating func mapping(map: Map) {
        newVipList <- map["newVipList"]
    }
}
extension Vip: Mappable {

    init?(map: Map) {

    }
    mutating func mapping(map: Map) {
        comics <- map["comics"]
        canMore <- map["canMore"]
        argName <- map["argName"]
        argValue <- map["argValue"]
        itemTitle <- map["itemTitle"]
        titleIconUrl <- map["titleIconUrl"]
        newTitleIconUrl <- map["newTitleIconUrl"]
        maxSize <- map["maxSize"]
        description <- map["description"]
    }
}
