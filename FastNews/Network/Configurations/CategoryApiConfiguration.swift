//
//  CategoryApiConfiguration.swift
//  FastNews
//
//  Created by Serhan Khan on 06/10/2021.
//

import Foundation

protocol CategoryApiConfiguration {
    var baseUrl: URL { get }
    var proxyPath: String { get }
    var apiKey: String { get }
}
