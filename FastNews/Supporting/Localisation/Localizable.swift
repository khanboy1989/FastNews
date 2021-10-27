//
//  Localizable.swift
//  FastNews
//
//  Created by Serhan Khan on 30/09/2021.
//

import Foundation

protocol LocalizableType {
    var localized: String { get }
}

extension LocalizableType where Self: RawRepresentable, Self.RawValue == String {
    var localized: String {
        return self.rawValue.news.localized
    }
}

struct Localizable {
    
    enum General: String, LocalizableType {
        case noInternet = "General.NoInternet"
    }
    
    enum Networking: String , LocalizableType {
        case noInternet = "Networking.NoInternet"
        case unknown = "Networking.Error.Unknown"
    }
    
    enum CategoryType: String, LocalizableType {
        case business = "CategoryType.Bussines"
        case entertainment = "CategoryType.Entertainment"
        case general = "CategoryType.General"
        case health = "CategoryType.Health"
        case science = "CategoryType.Science"
        case sports = "CategoryType.Sports"
        case technology = "CategoryType.Technology"
    }
}
