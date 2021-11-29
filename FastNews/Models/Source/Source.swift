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
    let category: String
    let country: String
}


extension Source: Mappable {
    init(map: Mapper) throws {
        id = try map.from("id")
        name = try map.from("name")
        description = try map.from("description")
        url = try map.from("url")
        category = try map.from("category")
        country = try map.from("country")
    }
    
    
}
