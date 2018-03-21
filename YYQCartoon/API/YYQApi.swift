//
//  YYQApi.swift
//  YYQCartoon
//
//  Created by kcl on 2018/3/21.
//  Copyright © 2018年 KCL. All rights reserved.
//

import Foundation
import Moya
import ObjectMapper
import RxSwift
import RxCocoa
import Result

final class RequestAlertPlugin: PluginType {

    private let viewController: UIViewController

    init(viewController: UIViewController) {
        self.viewController = viewController
    }

    func willSend(_ request: RequestType, target: TargetType) {

        guard let requestURLString = request.request?.url?.absoluteString else { return }

        let alertViewController = UIAlertController(title: "Sending Request", message: requestURLString, preferredStyle: .alert)
        alertViewController.addAction(UIAlertAction(title: "OK", style: .default, handler: nil))

        viewController.present(alertViewController, animated: true, completion: nil)
    }

    func didReceive(_ result: Result<Moya.Response, MoyaError>, target: TargetType) {


        guard case Result.failure(_) = result else { return }


        let alertViewController = UIAlertController(title: "Error", message: "Request failed with status code: ", preferredStyle: .alert)
        alertViewController.addAction(UIAlertAction(title: "OK", style: .default, handler: nil))

        viewController.present(alertViewController, animated: true, completion: nil)

    }
}

private let YYQEndpointMapping = {(target:YYQApi) -> Endpoint in

    let url = target.baseURL.appendingPathComponent(target.path).absoluteString
    let endpoint = Endpoint(url: url,
                                    sampleResponseClosure: {.networkResponse(200, target.sampleData)},
                                    method: target.method,
                                    task: target.task,
                                    httpHeaderFields: target.headers)

    print("url=\(url),param=\(String(describing: target.task))")
    let token = UserDefaults.standard.string(forKey: "accesstoken") ?? ""
    if token == "" {
        return endpoint.adding(newHTTPHeaderFields: [
            "Accept":"application/json",
            "Content-Type":"application/json",
            "Accept-Language":"en",
//            "Authorization":"key=\(MoveApi.apiKey)"
            ])
    }else{

        return endpoint.adding(newHTTPHeaderFields: [
            "Accept":"application/json",
            "Content-Type":"application/json",
            "Accept-Language":"en",
//            "Authorization":"key=\(MoveApi.apiKey),token=\(token)"
            ])
    }
}
//public final class func defaultRequestMapping(for endpoint: Endpoint, closure: RequestResultClosure) {
//    do {
//        let urlRequest = try endpoint.urlRequest()
//        closure(.success(urlRequest))
//    } catch MoyaError.requestMapping(let url) {
//        closure(.failure(MoyaError.requestMapping(url)))
//    } catch MoyaError.parameterEncoding(let error) {
//        closure(.failure(MoyaError.parameterEncoding(error)))
//    } catch {
//        closure(.failure(MoyaError.underlying(error, nil)))
//    }
//}

//private let YYQRequestTimeoutClosure = { (endpoint: Endpoint, done: @escaping MoyaProvider<YYQApi>.RequestResultClosure) in
//    guard let request = endpoint.urlRequest else { return }
//    request.timeoutInterval = 10    //设置请求超时时间
//    request.httpShouldHandleCookies = false
//    done(.success(request))
//}


/// 网络封装
class YYQRequest{

    private static let dProvider = MoyaProvider<YYQApi>()
    private static let YYQProvider = MoyaProvider<YYQApi>(
        endpointClosure:YYQEndpointMapping
//        plugins:[RequestAlertPlugin(viewController: (UIApplication.shared.keyWindow?.rootViewController)!)]
//        requestClosure:YYQRequestTimeoutClosure,
        )
    //获取Vip列表
    final class func getVipList() ->Observable<VipListModel>{

        return YYQProvider.rx.request(.vipList)
            .mapJSON()
            .asObservable()
            .mapObject(type:VipListModel.self)
    }
    //获取排行列表
    final class func getRankList() ->Observable<RankListModel>{

        return YYQProvider.rx.request(.rankList)
            .mapJSON()
            .asObservable()
            .mapObject(type:RankListModel.self)
    }
    //获取推荐列表
    final class func getRecommendList() ->Observable<RecommendListModel>{

        return YYQProvider.rx.request(.boutiqueList(sexType: 1))
            .mapJSON()
            .asObservable()
            .mapObject(type:RecommendListModel.self)
    }

    //获取订阅列表
    final class func getSubscribeList() ->Observable<SubscribeListModel>{

        return YYQProvider.rx.request(.subscribeList)
            .mapJSON()
            .asObservable()
            .mapObject(type:SubscribeListModel.self)
    }

}


enum YYQApi {

    case searchHot
    case searchRelative(inputText:String)   //相关搜索
    case searchResult(argCon:Int, q:String) //搜索结果
    case boutiqueList(sexType:Int)          //推荐列表
    case special(argCon:Int, page:Int)      //专题
    case vipList //VIP列表
    case subscribeList //订阅列表
    case rankList//排行列表
    case cateList//分类列表
    case comicList(argCon: Int, argName: String, argValue: Int, page: Int)//漫画列表
    case guessLike//猜你喜欢
    case detailStatic(comicid: Int)//详情(基本)
    case detailRealtime(comicid: Int)//详情(实时)
    case commentList(object_id: Int, thread_id: Int, page: Int)//评论
    case chapter(chapter_id: Int)//章节内容
}

extension YYQApi:TargetType
{
    private struct YYQApiKey {
        static var key = "fabe6953ce6a1b8738bd2cabebf893a472d2b6274ef7ef6f6a5dc7171e5cafb14933ae65c70bceb97e0e9d47af6324d50394ba70c1bb462e0ed18b88b26095a82be87bc9eddf8e548a2a3859274b25bd0ecfce13e81f8317cfafa822d8ee486fe2c43e7acd93e9f19fdae5c628266dc4762060f6026c5ca83e865844fc6beea59822ed4a70f5288c25edb1367700ebf5c78a27f5cce53036f1dac4a776588cd890cd54f9e5a7adcaeec340c7a69cd986:::open"
    }
    var baseURL: URL {
        return URL(string: "http://app.u17.com/v3/appV3_3/ios/phone")!

    }

    /// The path to be appended to `baseURL` to form the full `URL`.
    var path: String {
        switch self {

        case .searchHot: return "search/hotkeywordsnew"
        case .searchRelative: return "search/relative"
        case .searchResult: return "search/searchResult"
        case .boutiqueList: return "comic/boutiqueListNew"
        case .special: return "comic/special"
        case .vipList: return "list/vipList"
        case .subscribeList: return "list/newSubscribeList"
        case .rankList: return "rank/list"
        case .cateList: return "sort/mobileCateList"
        case .comicList: return "list/commonComicList"
        case .guessLike: return "comic/guessLike"
        case .detailStatic: return "comic/detail_static_new"
        case .detailRealtime: return "comic/detail_realtime"
        case .commentList: return "comment/list"
        case .chapter: return "comic/chapterNew"

        }
    }

    /// The HTTP method used in the request.
    var method: Moya.Method { return .get }

    /// Provides stub data for use in testing.
//    var sampleData: Data { get }

    /// The type of HTTP task to be performed.
    var task: Task {
        var parameters = ["time":Int32(Date().timeIntervalSince1970),
                          "device_id":UIDevice.current.identifierForVendor!.uuidString,
                          "key":YYQApiKey.key,
//                          "model": UIDevice.current.modelName,
                          "target": "U17_3.0",
                          "version": Bundle.main.infoDictionary!["CFBundleShortVersionString"]!]
        switch self {

            case .searchRelative(let inputText):
                parameters["inputText"] = inputText
            case .searchResult(let argCon, let q):
                parameters["argCon"] = argCon
                parameters["q"] = q
            case .boutiqueList(let sexType):
                parameters["sexType"] = sexType
                parameters["v"] = 3320101
            case .special(let argCon,let page):
                parameters["argCon"] = argCon
                parameters["page"] = max(1, page)
            case .cateList:
                parameters["v"] = 2

            case .comicList(let argCon, let argName, let argValue, let page):
                parameters["argCon"] = argCon
                if argName.count > 0 { parameters["argName"] = argName }
                parameters["argValue"] = argValue
                parameters["page"] = max(1, page)

            case .detailStatic(let comicid),
                 .detailRealtime(let comicid):
                parameters["comicid"] = comicid
                parameters["v"] = 3320101

            case .commentList(let object_id, let thread_id, let page):
                parameters["object_id"] = object_id
                parameters["thread_id"] = thread_id
                parameters["page"] = page

            case .chapter(let chapter_id):
                parameters["chapter_id"] = chapter_id
                default:break
        }

        return .requestParameters(parameters: parameters, encoding: URLEncoding.default)
    }

    /// The type of validation to perform on the request. Default is `.none`.
    var sampleData: Data { return "".data(using: String.Encoding.utf8)! }
    var headers: [String : String]? { return nil }
}










