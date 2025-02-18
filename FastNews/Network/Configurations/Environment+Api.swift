//
//  Environment+Api.swift
//  FastNews
//
//  Created by Serhan Khan on 07/10/2021.
//

import Moya
import Alamofire
import Foundation

private struct Configuration {
    struct Api {
        static var main: MainApiConfiguration = {
            return MainApiConfiguration()
        }()
        
        static var jsonPlaceHolder: JsonPlaceHolderApiConfiguration = {
            return JsonPlaceHolderApiConfiguration()
        }()
    }
}

extension Environment {
    
    var categoryApiConfiguration: CategoryApiConfiguration {
        return Configuration.Api.main
    }
    
    var sourceApiConfiguration: SourceApiConfiguration {
        return Configuration.Api.main
    }
    
    var postsJsonApiConfiguration: JsonPlaceHolderApiConfiguration {
        return Configuration.Api.jsonPlaceHolder
    }
    
    var categoryApiProvider: MoyaProvider<CategoryApi> {
        return createProvider()
    }

    var sourceApiProvider: MoyaProvider<SourceApi> {
        return createProvider()
    }
    
    var postApiProvider: MoyaProvider<PostApi> {
        return createProvider()
    }
    
    private func createProvider<T>() -> MoyaProvider<T> {
        let configuration = URLSessionConfiguration.default
        let session = Session(configuration: configuration)
        return MoyaProvider<T>(session: session)
    }
}
