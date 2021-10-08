//
//  MainApiConfiguration.swift
//  FastNews
//
//  Created by Serhan Khan on 06/10/2021.
//

import Foundation

struct MainApiConfiguration: CategoryApiConfiguration {
   
    let baseUrl: URL = {
        return URL(string: "https://newsapi.org")!
    }()
    
    let proxyPath: String = {
        return "/v2"
    }()
    
    let apiKey: String = {
        return "a72a96d5eae7479688b0e6504942508a"
    }()
 
}
