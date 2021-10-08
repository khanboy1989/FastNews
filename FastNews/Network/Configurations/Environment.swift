//
//  Environment.swift
//  FastNews
//
//  Created by Serhan Khan on 07/10/2021.
//

import Foundation

enum Environment {
    case debug
    case release
    
    
    static var current: Environment = {
        let result: Environment
        #if DEBUG
        result = .debug
        #else
        result = .release
        #endif
        return result
    }()
}
