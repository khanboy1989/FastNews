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
        return Observable.empty()
    }
}
