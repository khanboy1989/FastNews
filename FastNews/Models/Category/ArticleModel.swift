//
//  Article.swift
//  FastNews
//
//  Created by Serhan Khan on 08/10/2021.
//

import Foundation
import Mapper


struct ArticleModel {
    let source: SourceModel
    
}

extension ArticleModel: Mappable {
    init(map: Mapper) throws {
        source = try map.from("source")
    }
    
    
}
