//
//  PostApi.swift
//  FastNews
//
//  Created by Serhan Khan on 28.12.22.
//

import Foundation
import Moya


enum PostApi {
    case posts(config: PostsJsonPlaceHolderApiConfiguration)
}


extension PostApi: TargetType {
    
    var baseURL: URL {
        switch self {
        case let .posts(config) :
            return config.baseUrl
        }
    }
    
    var path: String {
        switch self {
        case let .posts(config):
            return config.proxyPath + "/posts"
        }
    }
    
    var method: Moya.Method {
        switch self {
        case .posts:
            return .get
        }
    }
    
    var sampleData: Data {
        return "{}".data(using: .utf8)!
    }
    
    var task: Task {
        switch self {
        case .posts:
            return .requestPlain
        }
    }
    
    var headers: [String: String]? {
        return ["Content-Type": "application/json"]
    }
    
    
    
}
