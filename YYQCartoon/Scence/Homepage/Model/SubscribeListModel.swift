//
//  SubscribeListModel.swift
//  YYQCartoon
//
//  Created by kcl on 2018/3/21.
//  Copyright © 2018年 KCL. All rights reserved.
//

import Foundation
import ObjectMapper


struct SubscribeListModel {

    var code:NSNumber?
    var data:SubscribeList?
}

struct SubscribeList {

    var stateCode:NSNumber?
    var message:String?
    var returnData:SubscribeListData?
}

struct SubscribeListData {

    var newSubscribeList:[Subscribe]?
}

struct Subscribe {

    var canMore:Bool?
    var comics:[Comic]?
    var argName:String?
    var argValue:String?
    var itemTitle:String?
    var titleIconUrl:String?
    var newTitleIconUrl:String?
    var maxSize:NSNumber?
    var description:String?

}

extension Subscribe: Mappable {

    init?(map: Map) {

    }
    mutating func mapping(map: Map) {
        canMore <- map["canMore"]
        comics <- map["comics"]
        argName <- map["argName"]
        argValue <- map["argValue"]
        itemTitle <- map["itemTitle"]
        titleIconUrl <- map["titleIconUrl"]
        newTitleIconUrl <- map["newTitleIconUrl"]
        maxSize <- map["maxSize"]
        description <- map["description"]
    }
}

extension SubscribeListData: Mappable {

    init?(map: Map) {

    }


    mutating func mapping(map: Map) {
        newSubscribeList <- map["newSubscribeList"]
    }
}

extension SubscribeList: Mappable {

    init?(map: Map) {

    }
    mutating func mapping(map: Map) {
        stateCode <- map["stateCode"]
        message <- map["message"]
        returnData <- map["returnData"]
    }
}

extension SubscribeListModel: Mappable {

    init?(map: Map) {

    }
    mutating func mapping(map: Map) {
        code <- map["code"]
        data <- map["data"]
    }
}
