//
//  Post.swift
//  FastNews
//
//  Created by Serhan Khan on 28.12.22.
//

import Foundation
import Mapper

struct Post {
    let userId: Int
    let id: Int
    let title: String
    let body: String
}

extension Post: Mappable {
    
    init(map: Mapper) throws {
        userId = try map.from("userId")
        id = try map.from("id")
        title = try map.from("title")
        body = try map.from("body")
    }
}

