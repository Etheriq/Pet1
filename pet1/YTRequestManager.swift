//
//  YTRequestManager.swift
//  pet1
//
//  Created by Yuriy T on 30.09.2017.
//  Copyright © 2017 xeon.pet1.education. All rights reserved.
//

import Foundation
import PromiseKit
import Alamofire

enum YTRequestError: Error {
    case responseJsonNotValid
    case requestError(error: Error)
    case badRequestPath
}

protocol YTRequestParamsProtocol {
    var path: String { get }
    var parameters: [String: Any]? { get }
    var methodType: HTTPMethod { get }
    var keyPath: String { get }
    var encoding: ParameterEncoding { get }
    var headers: [String: String] { get }
}
protocol YTRequestProtocol: class {
    static func request(params: YTRequestParamsProtocol, additionalParameters: [String: Any]?, additionalHeader: [String: String]?) -> Promise<[String: Any]>
}

class YTRequestManager: YTRequestProtocol {
    private init() {}
    
    static func request(params: YTRequestParamsProtocol, additionalParameters: [String: Any]? = nil, additionalHeader: [String: String]? = nil) -> Promise<[String: Any]> {
        let pending = Promise<[String: Any]>.pending()
        
        var requestHeaders = params.headers
        if let additHeader = additionalHeader {
            requestHeaders.merge(dict: additHeader)
        }
        
        var requestParams = params.parameters
        if let additParam = additionalParameters {
            if let _ = requestParams {
                requestParams!.merge(dict: additParam)
            } else {
                requestParams = additParam
            }
        }
        
//        guard let urll = URL(string:params.path) else { return pending.reject(YTRequestError.badRequestPath) } // what is wrong here ???
        
        let baseUrlPath = "\(Bundle.main.object(forInfoDictionaryKey: "APP_SERVER")!)/api"
        Alamofire.request(URL(string:baseUrlPath + params.path)!, method: params.methodType, parameters: requestParams, encoding: params.encoding, headers: requestHeaders)
        .validate(statusCode: 200..<300)
        .validate(contentType: ["application/json"])
        .responseJSON { response in
            switch response.result {
            case .success:
                guard let responseJson = response.result.value as? [String: Any],
                      let json = responseJson[params.keyPath] as? [String: Any]
                else { return pending.reject(YTRequestError.responseJsonNotValid) }
                
                pending.fulfill(json)
                debugPrint(json)
            case .failure(let error):
                pending.reject(YTRequestError.requestError(error: error))
                print(error)
            }
        }
        
        return pending.promise
    }
}
