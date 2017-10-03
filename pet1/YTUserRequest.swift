//
//  User.swift
//  pet1
//
//  Created by Yuriy T on 30.09.2017.
//  Copyright © 2017 xeon.pet1.education. All rights reserved.
//

import Foundation
import Alamofire

enum YTUserRequest: YTRequestParamsProtocol {
    case getUserWithId(userId: Int)
    case getMe
    case updateProfile(user: YTUser)
    case getList(forPage: Int, andLimit: Int)
    case uploadImage(imageData: Data)
    case removeImage(imageId: Int)
    case uploadAvatar(avatarData: Data)
}

extension YTUserRequest {
    var path: String {
        switch self {
        case .getList(let forPage, let andLimit):
            return "/list?page=\(forPage)&limit=\(andLimit)"
        case .getMe:
            return "/user"
        case .getUserWithId(let userId):
            return "/user/\(userId)"
        case .updateProfile(_):
            return "/profile"
        case .uploadAvatar(_):
            return "/avatar"
        case .uploadImage(_):
            return "/image"
        case .removeImage(let imageId):
            return "/image/\(imageId)"
        }
    }
    
    var parameters: [String: Any]? {
        switch self {
        case .updateProfile(let user):
            return [
                "firstName": user.firstName,
                "lastName": user.lastName,
                "email": user.email
            ]
        default:
            return nil
        }
    }
    
    var methodType: HTTPMethod {
        switch self {
        case .uploadImage(_), .uploadAvatar(_):
            return .post
        case .updateProfile(_):
            return .put
        case .removeImage(_):
            return .delete
        default:
            return .get
        }
    }
    
    var keyPath: String {
        switch self {
        case .getList(_, _):
            return "list"
        case .getMe, .getUserWithId(_):
            return "user"
        case .updateProfile(_):
            return "profile"
        case .uploadAvatar(_), .uploadImage(_), .removeImage(_):
            return "image"
        }
    }
    
    var encoding: ParameterEncoding {
        switch self {
        case .getList(_,_), .getUserWithId(_), .getMe:
            return URLEncoding.default
        default:
            return JSONEncoding.default
        }
    }
    
    var taskType: YTRequestTaskType {
        switch self {
        case .uploadAvatar(let data), .uploadImage(let data):
            return .upload(data: data)
        default:
            return .request
        }
    }
    
    var headers: [String: String] {
        var header = [Constants.apiHeaderAuthentificationKey : YTKeychainHelper.getApiToken() ?? ""]
        
        switch self {
        case .getList(_, _):
            return [:]
        case .uploadAvatar(_), .uploadImage(_):
            header["Content-Type"] = "image/png"
            
            return header
        default:
            return header
        }
    }
}
