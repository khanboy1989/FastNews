//
//  NewsCompatible.swift
//  FastNews
//
//  Created by Serhan Khan on 30/09/2021.
//

import Foundation

struct News<Base> {
    public let base: Base
    
    public init(_ base: Base) {
        self.base = base
    }
}

protocol NewsCompatible {
    associatedtype NewsCompatibleType
    
    static var news: News<NewsCompatibleType>.Type { get }
    var news: News<NewsCompatibleType> { get }
}

extension NewsCompatible {
    public static var news: News<Self>.Type {
        return News<Self>.self
    }

    public var news: News<Self> {
        return News(self)
    }
}
