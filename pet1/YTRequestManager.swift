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
    case requestError400
    case requestError403
    case requestError404
    case badRequestPath
}

enum YTRequestTaskType {
    case request
    case upload(data: Data)
}

protocol YTRequestParamsProtocol {
    var path: String { get }
    var parameters: [String: Any]? { get }
    var methodType: HTTPMethod { get }
    var keyPath: String { get }
    var encoding: ParameterEncoding { get }
    var headers: [String: String] { get }
    var taskType: YTRequestTaskType { get }
}
protocol YTRequestProtocol: class {
     func request(params: YTRequestParamsProtocol, additionalParameters: [String: Any]?, additionalHeader: [String: String]?) -> Promise<[String: Any]>
}

class YTRequestManager: YTRequestProtocol {
    private init() {}
    static let shared = YTRequestManager()
    
    func request(params: YTRequestParamsProtocol, additionalParameters: [String: Any]? = nil, additionalHeader: [String: String]? = nil) -> Promise<[String: Any]> {
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
      
        let baseUrlPath = "\(Bundle.main.object(forInfoDictionaryKey: "APP_SERVER")!)/api"
        var dataRequest: DataRequest
        switch params.taskType {
        case .request:
            dataRequest = Alamofire.request(URL(string:baseUrlPath + params.path)!, method: params.methodType, parameters: requestParams, encoding: params.encoding, headers: requestHeaders) as DataRequest
        case .upload(let data):
            dataRequest = Alamofire.upload(data, to: URL(string:baseUrlPath + params.path)!, method: params.methodType, headers: requestHeaders) as UploadRequest
        }
        
        dataRequest
        .validate(statusCode: 200..<300)
//        .validate(contentType: ["application/json"])
        .responseJSON { response in
            switch response.result {
            case .success:
                guard let responseJson = response.result.value as? [String: Any],
                      let json = responseJson[params.keyPath] as? [String: Any]
                else {
                    pending.reject(YTRequestError.responseJsonNotValid)
                    return
                }
                
                pending.fulfill(json)
                debugPrint(json)
            case .failure(let error):
                if response.response?.statusCode == 400 {
                    pending.reject(YTRequestError.requestError400)
                } else if response.response?.statusCode == 403 {
                    pending.reject(YTRequestError.requestError403)
                } else if response.response?.statusCode == 404 {
                    pending.reject(YTRequestError.requestError404)
                } else {
                    pending.reject(YTRequestError.requestError(error: error))
                }
                debugPrint(error)
            }
        }
        
        return pending.promise
    }
}
