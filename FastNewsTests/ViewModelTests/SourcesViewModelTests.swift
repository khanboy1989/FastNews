//
//  SourcesViewModelTests.swift
//  FastNewsTests
//
//  Created by Serhan Khan on 25/01/2022.
//

import XCTest
import RxSwift
import RxTest
import RxFlow
@testable import FastNews

class SourceViewModelTests: XCTestCase {
    
    var sourcesViewModel: SourcesViewModel!
    
    override func setUpWithError() throws {
        createSourcesViewModel()
    }
    
    private func createSourcesViewModel() {
        sourcesViewModel = SourcesViewModel(reachabilityService: ReachabilityServiceMock(), sourceService: SourceServiceMock())
    }
}
