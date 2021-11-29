//
//  SourceApi.swift
//  FastNews
//
//  Created by Serhan Khan on 29/11/2021.
//

import Foundation
import Moya

enum SourceApi {
    case sources(config: SourceApiConfiguration, country: String)
}

extension SourceApi: TargetType {
    var baseURL: URL {
        switch self {
        case let .sources(config, _) :
            return config.baseUrl
        }
    }
    
    var path: String {
        switch self {
        case let .sources(config, _):
            return config.proxyPath + "/sources"
        }
    }
    
    var method: Moya.Method {
        switch self {
        case .sources:
            return .get
        }
    }
    
    var sampleData: Data {
        return "{}".data(using: .utf8)!
    }
    
    var task: Task {
        switch self {
        case let .sources(config, country):
             let urlParameters: [String: Any] = ["apiKey": config.apiKey, "country": country]
            return .requestParameters(parameters: urlParameters, encoding: URLEncoding.default)
        }
    }
    
    var headers: [String : String]? {
        return ["Content-Type": "application/json"]
    }
}
