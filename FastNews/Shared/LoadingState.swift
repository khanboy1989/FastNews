//
//  LoadingState.swift
//  FastNews
//
//  Created by Serhan Khan on 26/10/2021.
//

import Foundation


enum LoadingState<T> {
    case loading
    case success(T)
    case error(LoadingStateError)
}

enum LoadingStateError {
    case custom(String)
    case unknown
    case noInternet
    
    var description: String {
        switch self {
        case let .custom(text):
            return text
        case .unknown:
            return Localizable.Networking.unknown.localized
        case .noInternet:
            return Localizable.Networking.noInternet.localized
        }
    }
}
