//
//  SourceApiConfiguration.swift
//  FastNews
//
//  Created by Serhan Khan on 29/11/2021.
//

import Foundation

protocol SourceApiConfiguration {
    var baseUrl: URL { get }
    var proxyPath: String { get }
    var apiKey: String { get }
}
