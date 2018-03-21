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


class YYQRequest{

    private static let dProvider = MoyaProvider<YYQApi>()
    private static let YYQProvider = MoyaProvider<YYQApi>(
        endpointClosure:YYQEndpointMapping
//        plugins:[RequestAlertPlugin(viewController: (UIApplication.shared.keyWindow?.rootViewController)!)]
//        requestClosure:YYQRequestTimeoutClosure,
        )

    final class func getVipList() ->Observable<VipList>{

        return YYQProvider.rx.request(.vipList)
            .mapJSON()
            .asObservable()
            .mapObject(type:VipList.self)
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
            default:break
        }

        return .requestParameters(parameters: parameters, encoding: URLEncoding.default)
    }

    /// The type of validation to perform on the request. Default is `.none`.
    var sampleData: Data { return "".data(using: String.Encoding.utf8)! }
    var headers: [String : String]? { return nil }
}



enum RxSwiftMoyaError:String {

    case ParseJSONError
    case OtherError
}
extension RxSwiftMoyaError:Swift.Error{}

extension Observable {

    public func mapObject<T:Mappable>(type:T.Type) -> Observable<T> {

        return self.map{ response in

            //if response is a dictionary, then use ObjectMapper to map the dictionary
            //if not throw an error
            guard let dict = response as? [String:Any] else {

                throw RxSwiftMoyaError.ParseJSONError
            }
            if let error = self.parseError(response: dict){
                throw error
            }
            print("response=\(dict)")
            return Mapper<T>().map(JSON: dict)!
        }
    }
    public func mapArray<T:Mappable>(type:T.Type) ->Observable<[T]>{

        return self.map{ response in

            guard let array = response as? [[String:Any]] else{

                throw RxSwiftMoyaError.ParseJSONError
            }

            for dict:[String :Any] in array {

                if let error = self.parseError(response: dict){

                    throw error
                }
            }
            return Mapper<T>().mapArray(JSONArray: array)
        }
    }

    final fileprivate func parseError(response:[String :Any]?) -> NSError?{

        var error:NSError?

        if let value = response{
            var code:Int?
            var msg:String?

            if let errorDic = value["error"] as? [String:Any]{

                code = errorDic["code"] as? Int
                msg = errorDic["msg"] as? String
                error = NSError(domain: "Network", code: code!, userInfo: [NSLocalizedDescriptionKey:msg ?? ""])
            }
        }
        return error
    }

    final fileprivate func parseServerError() -> Observable {

        return self.map{ (response) in

            let name = type(of: response)
            print(name)

            guard let dict = response as? [String:Any] else {

                throw RxSwiftMoyaError.ParseJSONError
            }
            if let error = self.parseError(response: dict){
                throw error
            }
            return self as! Element
        }
    }


}







