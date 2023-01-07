//
//  Bundle+TestData.swift
//  FastNewsTests
//
//  Created by Serhan Khan on 01/02/2022.
//

import Foundation

final class TestsBundleClass { }

extension Bundle {
    static var fastNewsTests: Bundle {
        return Bundle(for: TestsBundleClass.self)
    }
}
