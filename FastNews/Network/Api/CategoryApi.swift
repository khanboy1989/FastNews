//
//  CategoryApi.swift
//  FastNews
//
//  Created by Serhan Khan on 06/10/2021.
//

import Foundation
import Moya

enum CategoryApi {
    case topHeadLines(config: CategoryApiConfiguration, category: CategoryType, lang: String)
}

extension CategoryApi: TargetType {
    var baseURL: URL {
        switch self {
        case let .topHeadLines(config, _, _):
            return config.baseUrl
        }
    }
    
    var path: String {
        switch self {
        case let .topHeadLines(config, _, _ ):
            return "\(config.proxyPath)/top-headlines"
        }
    }
    
    var method: Moya.Method {
        switch self {
        case .topHeadLines:
            return .get
        }
    }
    
    var sampleData: Data {
        return "{}".data(using: .utf8)!
    }
    
    var task: Task {
        switch self {
        case .topHeadLines(let config, let categoryType, let lang):
            let urlParameters: [String: Any] = ["apiKey": config.apiKey, "category": categoryType.rawValue, "language": lang]
            return .requestCompositeData(bodyData: Data(), urlParameters: urlParameters)
        }
    }
    
    var headers: [String: String]? {
        return ["Content-Type": "application/json"]
    }
}
