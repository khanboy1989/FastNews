//
//  Article.swift
//  FastNews
//
//  Created by Serhan Khan on 08/10/2021.
//

import Foundation
import Mapper

struct ArticleModel {
    let source: SourceModel?
    let author: String?
    let title: String?
    let description: String?
    let url: String?
    let urlToImage: String?
    let publishedAt: String?
    let content: String?
}

extension ArticleModel: Mappable {
    init(map: Mapper) throws {
        source = map.optionalFrom("source")
        author = map.optionalFrom("author")
        title = map.optionalFrom("title")
        description = map.optionalFrom("description")
        url = map.optionalFrom("url")
        urlToImage = map.optionalFrom("urlToImage")
        publishedAt = map.optionalFrom("publishedAt")
        content = map.optionalFrom("content")
    }
    
}
