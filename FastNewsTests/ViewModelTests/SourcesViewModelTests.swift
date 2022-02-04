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

@testable import FastNews

class SourceViewModelTests: XCTestCase {
    
    var viewModel: SourcesViewModel!
    var scheduler: TestScheduler!
    var subscription: Disposable!
    let disposeBag = DisposeBag()
    
    override func setUpWithError() throws {
        scheduler = TestScheduler(initialClock: 0)
        createSourcesViewModel()
    }
    
    private func createSourcesViewModel() {
        viewModel = SourcesViewModel(reachabilityService: ReachabilityServiceMock(), sourceService: SourceServiceMock())
    }
    
    func testSectionItems() {
        let exp: XCTestExpectation = expectation(description: "wait testSectionItems")
        var sec: [SourcesViewModel.Section]?
        viewModel.input.sources.execute()
        viewModel.output.sections
            .do(onNext: { sections in
                sec = sections
                DispatchQueue.main.async {
                    exp.fulfill()
                }
            })
            .drive()
            .disposed(by: disposeBag)
        
        wait(for: [exp], timeout: 5)
        if let sec = sec {
            XCTAssertEqual(sec.count, 1)
        } else {
            XCTAssertNil(sec)
        }
    }
    
    func testLoadingState() {
        let exp: XCTestExpectation? = expectation(description: "wait testLoadingState")
        
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
    
    func testSourceItems() {
        let exp: XCTestExpectation = expectation(description: "wait testSourceItems")
        var sourceItems: [Source]?
        
        viewModel.input.sources.execute()
        
        viewModel.output.loadingState.subscribe(onNext: { state in
            switch state {
            case let .success(sources):
                sourceItems = sources
            default:
                sourceItems = nil
            }
            exp.fulfill()
        })
            .disposed(by: disposeBag)
        
        wait(for: [exp], timeout: 5)
    
        XCTAssertNotNil(sourceItems)
        XCTAssertEqual(sourceItems?.count, 56)
    }
    
    func testShowSourceMain() {
        let observer = scheduler.createObserver(Step.self)
        
        guard let sources = SourceModelTest(jsonFile: .sourcesData) else {
            XCTFail("expected sources model not to be nil")
            return
        }
        
        if let randomItem = sources.sources.first {
            scheduler.scheduleAt(0) {
                self.subscription = self.viewModel.steps.subscribe(observer)
            }
            scheduler.start()
            viewModel.input.itemSelected.execute(randomItem)
            
            let result = observer.events.first.map {
                $0.value.element
            }
            
            let appStepResult = result as? AppSteps
            XCTAssertNotNil(appStepResult)
            
            switch appStepResult {
            case let .sourceMain(source):
                XCTAssertNotNil(source)
            default:
                XCTFail("expected testShowSourceMain step")
            }
            
        }
        
    }
}
