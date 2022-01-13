//
//  Source.swift
//  FastNews
//
//  Created by Serhan Khan on 29/11/2021.
//

import Foundation
import Mapper

struct Source {
    let id: String
    let name: String
    let description: String
    let url: String
    let category: Category
    let country: String
}

enum Category: String {
    
    //swiftlint:disable redundant_string_enum_value
    case business = "business"
    case entertainment = "entertainment"
    case general = "general"
    case health = "health"
    case science = "science"
    case sports = "sports"
    case technology = "technology"
    //swiftlint:enable redundant_string_enum_value
}

extension Source: Mappable {
    init(map: Mapper) throws {
        print("json = \(map)")
        id = try map.from("id")
        name = try map.from("name")
        description = try map.from("description")
        url = try map.from("url")
        category = try map.from("category")
        country = try map.from("country")
    }
}
