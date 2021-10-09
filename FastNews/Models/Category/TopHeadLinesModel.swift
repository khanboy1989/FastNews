//
//  CategoryType.swift
//  FastNews
//
//  Created by Serhan Khan on 29/09/2021.
//

import Foundation
import Mapper

struct TopHeadLinesModel {
    var status: String?
    var totalResults: Int?
    var articles: [ArticleModel]
}

extension TopHeadLinesModel: Mappable {
    init(map: Mapper) throws {
        status = map.optionalFrom("status")
        totalResults = map.optionalFrom("totalResults")
        articles = try map.from("articles")
    }
}
