//
//  SourceServiceMock.swift
//  FastNewsTests
//
//  Created by Serhan Khan on 25/01/2022.
//

import Foundation
import RxSwift
import RxCocoa

@testable import FastNews

class SourceServiceMock: SourceServiceType {
    
    func sources(_ country: String) -> Observable<[Source]> {
        return Observable.of(createSources())
    }
    
    private func createSources() -> [Source] {
        if let array = SourceModelTest(jsonFile: .sourcesData)?.sources {
            return array
        }
        return []
    }
}
