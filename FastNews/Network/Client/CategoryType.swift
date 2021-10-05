//
//  CategoryType.swift
//  FastNews
//
//  Created by Serhan Khan on 29/09/2021.
//

import Foundation

enum CategoryType: CaseIterable {

    case business
    case entertainment
    case general
    case health
    case science
    case sports
    case technology
    
    var title: String {
        switch self {
        case .business:
            return Localizable.CategoryType.business.localized
        case .entertainment:
            return Localizable.CategoryType.entertainment.localized
        case .general:
            return Localizable.CategoryType.general.localized
        case .health:
            return Localizable.CategoryType.health.localized
        case .science:
            return Localizable.CategoryType.science.localized
        case .sports:
            return Localizable.CategoryType.sports.localized
        case .technology:
            return Localizable.CategoryType.technology.localized
        }
    }
    
    var index: Int {
        switch self {
        case .business:
            return 0
        case .entertainment:
            return 1
        case .general:
            return 2
        case .health:
            return 3
        case .science:
            return 4
        case .sports:
            return 5
        case .technology:
            return 6
        }
    }
}
