//
//  SourceModel+TestData.swift
//  FastNewsTests
//
//  Created by Serhan Khan on 01/02/2022.
//

import Mapper

@testable import FastNews

enum SourceJsonFile: String {
    // swiftlint:disable redundant_string_enum_value
    case sourcesData = "sourcesData"
    // swiftlint:enable redundant_string_enum_value
}

extension SourceModelTest {
    init?(jsonFile: SourceJsonFile) {
        guard let path = Bundle.fastNewsTests.path(forResource: jsonFile.rawValue, ofType: "json"),
                let data = try? Data(contentsOf: URL(fileURLWithPath: path)),
              let jsonObject = try? JSONSerialization.jsonObject(with: data),
              let jsonDictionary = jsonObject as? NSDictionary else {
                  return nil
              }
            
        try? self.init(map: Mapper(JSON: jsonDictionary))
    }
}

struct SourceModelTest: Mappable {
    let sources: [Source]
    
    init(map: Mapper) throws {
        sources = try map.from("sources")
    }
}
