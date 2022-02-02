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
import RxCocoa
import RxDataSources
import Action

@testable import FastNews

class SourceViewModelTests: XCTestCase {
    
    var viewModel: SourcesViewModel!
    var scheduler: TestScheduler!
    
    let disposeBag = DisposeBag()
    
    override func setUpWithError() throws {
        scheduler = TestScheduler(initialClock: 0)
        createSourcesViewModel()
    }
    
    private func createSourcesViewModel() {
        viewModel = SourcesViewModel(reachabilityService: ReachabilityServiceMock(), sourceService: SourceServiceMock())
    }
    
    func testLoadingState() {
        let exp: XCTestExpectation? = expectation(description: "wait testSections")
        
        var state: LoadingState<[Source]>?
        
        viewModel.output.loadingState.subscribe(onNext: { s in
            state = s
            exp?.fulfill()
        })
            .disposed(by: disposeBag)
        
        waitForExpectations(timeout: 1) { (error) in
            guard let error = error else { return }
            XCTFail("Timeout error: \(String(describing: error))")
        }
        
        if let state = state {
            XCTAssertNotNil(state)
        }
    }
}
