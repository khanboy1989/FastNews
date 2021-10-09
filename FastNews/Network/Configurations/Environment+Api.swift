//
//  Environment+Api.swift
//  FastNews
//
//  Created by Serhan Khan on 07/10/2021.
//

import Moya
import Alamofire

private struct Configuration {
    struct Api {
        static var main: MainApiConfiguration = {
            return MainApiConfiguration()
        }()
    }
}

extension Environment {
    
    var categoryApiConfiguration: CategoryApiConfiguration {
        return Configuration.Api.main
    }
    
    var categoryApiProvider: MoyaProvider<CategoryApi> {
        return createProvider()
    }
    
    private func createProvider<T>() -> MoyaProvider<T> {
        let configuration = URLSessionConfiguration.default
        let session = Session(configuration: configuration)
        return MoyaProvider<T>(session: session)
    }
}
