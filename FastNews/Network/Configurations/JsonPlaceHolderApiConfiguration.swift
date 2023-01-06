//
//  JsonPlaceHolderApiConfiguration.swift
//  FastNews
//
//  Created by Serhan Khan on 27.12.22.
//

import Foundation

struct JsonPlaceHolderApiConfiguration: PostsJsonPlaceHolderApiConfiguration {
    let baseUrl: URL = {
        return URL(string: "https://jsonplaceholder.typicode.com")!
    }()
    
    let proxyPath: String = {
        return ""
    }()
    
    let apiKey: String = {
        return ""
    }()
}
