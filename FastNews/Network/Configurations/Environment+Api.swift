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
        
        if #available(iOS 13.0, *) {
            configuration.tlsMaximumSupportedProtocolVersion = .TLSv12
            configuration.tlsMinimumSupportedProtocolVersion = .TLSv12
            configuration.tlsMaximumSupportedProtocol = SSLProtocol.tlsProtocol12
            configuration.tlsMinimumSupportedProtocol = SSLProtocol.tlsProtocol12
        } else {
            configuration.tlsMaximumSupportedProtocol = SSLProtocol.tlsProtocol12
            configuration.tlsMinimumSupportedProtocol = SSLProtocol.tlsProtocol12
        }
        
        let manager = SessionManager(configuration: configuration)
        return MoyaProvider<T>(manager:manager)

    }
}
