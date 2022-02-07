//
//  ArticleModel+TestData.swift
//  FastNewsTests
//
//  Created by Serhan Khan on 07/02/2022.
//

import Mapper

@testable import FastNews

enum ArticlesJsonFile: String {
    // swiftlint:disable redundant_string_enum_value
    case articleData = "articlesData"
    // swiftlint:enable redundant_string_enum_value
}

extension ArticlesModelTest {
    init?(jsonFile: ArticlesJsonFile) {
        guard let path = Bundle.fastNewsTests.path(forResource: jsonFile.rawValue, ofType: "json"),
                let data = try? Data(contentsOf: URL(fileURLWithPath: path)),
              let jsonObject = try? JSONSerialization.jsonObject(with: data),
              let jsonDictionary = jsonObject as? NSDictionary else {
                  return nil
              }
            
        try? self.init(map: Mapper(JSON: jsonDictionary))
    }
}

struct ArticlesModelTest: Mappable {
    let articles: [ArticleModel]
    
    init(map: Mapper) throws {
        articles = try map.from("articles")
    }
}
