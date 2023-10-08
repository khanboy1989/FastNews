//
//  PostsJsonPlaceHolderApiConfiguration.swift
//  FastNews
//
//  Created by Serhan Khan on 27.12.22.
//

import Foundation

protocol PostsJsonPlaceHolderApiConfiguration {
    var baseUrl: URL { get }
    var proxyPath: String { get }
    var apiKey: String { get }
}
