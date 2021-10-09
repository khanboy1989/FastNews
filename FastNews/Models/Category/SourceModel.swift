//
//  File.swift
//  FastNews
//
//  Created by Serhan Khan on 08/10/2021.
//

import Foundation
import Mapper

struct SourceModel {
    let id: String?
    let name: String?
}

extension SourceModel: Mappable {
    init(map: Mapper) throws {
        id = map.optionalFrom("id")
        name = map.optionalFrom("name")
    }
    
}
