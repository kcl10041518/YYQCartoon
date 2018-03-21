//
//  RecommendList.swift
//  YYQCartoon
//
//  Created by kcl on 2018/3/21.
//  Copyright © 2018年 KCL. All rights reserved.
//

import Foundation
import ObjectMapper

struct RecommendListModel {

    var code:NSNumber?
    var data:RecommendList?
}

struct RecommendList {

    var stateCode:NSNumber?
    var message:String?
    var returnData:RecommendData?
}

struct RecommendData {

    var galleryItems:[GalleryItem]?
    var textItems:[TextItem]?
    var comicLists:[ComicList]?
    var editTime:String?
}

struct GalleryItem {

    var linkType:NSNumber?
    var cover:String?
    var id:NSNumber?
    var title:String?
    var content:String?
//    var ext:
}
struct TextItem {

}
struct ComicList {

    var comicType:NSNumber?
    var comics:[Comic]?
    var canedit:NSNumber?
    var sortId:String?
    var titleIconUrl:String?
    var newTitleIconUrl:String?
    var description:String?
    var itemTitle:String?
    var argName:String?
    var argValue:String?
    var argType:String?
}

struct Comic {
    //这里面有两块数据源
    var comicId:NSNumber?
    var wideCover:String?
    var tags:Array<Any>?
    var subTitle:String?
    var description:String?
    var cornerInfo:String?
    var short_description:String?
    var author_name:String?
    var is_vip:NSNumber?

    var cover:String?
    var name:String?
    var argName:String?
    var argValue:NSNumber?
    var itemTitle:String?

}
extension Comic: Mappable {

    init?(map: Map) {

    }
    mutating func mapping(map: Map) {


        comicId <- map["comicId"]
        wideCover <- map["wideCover"]
        tags <- map["tags"]
        subTitle <- map["subTitle"]
        description <- map["description"]
        cornerInfo <- map["cornerInfo"]
        short_description <- map["short_description"]
        author_name <- map["author_name"]
        is_vip <- map["is_vip"]

        cover <- map["cover"]
        name <- map["name"]
        argName <- map["argName"]
        argValue <- map["argValue"]
        itemTitle <- map["itemTitle"]
    }
}

extension GalleryItem: Mappable {

    init?(map: Map) {

    }
    mutating func mapping(map: Map) {
        linkType <- map["linkType"]
        cover <- map["cover"]
        id <- map["id"]
        title <- map["title"]
        content <- map["content"]
    }
}

extension RecommendList: Mappable {

    init?(map: Map) {

    }
    mutating func mapping(map: Map) {

        stateCode <- map["stateCode"]
        message <- map["message"]
        returnData <- map["returnData"]
    }
}


extension RecommendData: Mappable {

    init?(map: Map) {

    }
    mutating func mapping(map: Map) {
        galleryItems <- map["galleryItems"]
        textItems <- map["textItems"]
        comicLists <- map["comicLists"]
        editTime <- map["editTime"]
    }
}

extension RecommendListModel: Mappable {

    init?(map: Map) {

    }
    mutating func mapping(map: Map) {
        code <- map["code"]
        data <- map["data"]
    }
}



extension ComicList: Mappable {

    init?(map: Map) {

    }

    mutating func mapping(map: Map) {

        comicType <- map["comicType"]
        comics <- map["comics"]
        canedit <- map["canedit"]
        sortId <- map["sortId"]
        titleIconUrl <- map["titleIconUrl"]
        newTitleIconUrl <- map["newTitleIconUrl"]
        description <- map["description"]
        argName <- map["argName"]
        argValue <- map["argValue"]
        argType <- map["argType"]
    }
}

