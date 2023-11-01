//
//  CategoriesViewModelTests.swift
//  FastNewsTests
//
//  Created by Serhan Khan on 06/02/2022.
//

import XCTest
import RxSwift
import RxTest
import RxFlow
import RxCocoa

@testable import FastNews

class CategoriesViewModelTest: XCTestCase {
    
    var viewModel: CategoriesViewModel!
    var scheduler: TestScheduler!
    var subscription: Disposable!
    private let disposeBag = DisposeBag()
    
    override func setUpWithError() throws {
        scheduler = TestScheduler(initialClock: 0)
        createCategoriesViewModel()
    }
    
    private func createCategoriesViewModel() {
        viewModel = CategoriesViewModel(reachabilityService: ReachabilityServiceMock(), categoryService: CategoryServiceMock())
    }
    
    func testCategoryTypes() {
        let exp: XCTestExpectation = expectation(description: "wait testCategoryTypes")
        var customSegmentItems: [CustomSegmentItem]?
        
        viewModel.output.categoryTypes.do(onNext: { segmentItems in
            customSegmentItems = segmentItems
            exp.fulfill()
        })
            .drive()
            .disposed(by: disposeBag)
        
            wait(for: [exp], timeout: 1)
            
            XCTAssertEqual(customSegmentItems?.count, 7)
            XCTAssertNotNil(customSegmentItems)
    }
    
    func testDefaultSelectedCategoryType() {
        let exp: XCTestExpectation = expectation(description: "wait testDefaultSelectedCategoryType")
        var selectedCategoryType: CategoryType?
        viewModel.output.selectedCategoryType.do(onNext: { type in
            selectedCategoryType = type
            exp.fulfill()
        })
            .drive()
            .disposed(by: disposeBag)
        
        wait(for: [exp], timeout: 5)
        XCTAssertEqual(selectedCategoryType, .business)
        XCTAssertNotNil(selectedCategoryType)
    }
    
    func testSelectedCategoryType() {
        let exp: XCTestExpectation = expectation(description: "wait testSelectedCategoryType")
        
        var selectedType: CategoryType?

        viewModel.input.selectedCategoryType.execute(1)
        
        viewModel.output.selectedCategoryType.do(onNext: { selectedCatType in
            selectedType = selectedCatType
            exp.fulfill()
        })
            .drive()
            .disposed(by: disposeBag)
    
        wait(for: [exp], timeout: 1)
            
         XCTAssertEqual(selectedType, .entertainment)
    }
    
    func testLoadingState() {
        let exp: XCTestExpectation? = expectation(description: "wait testLoadingState")
        
        var state: LoadingState<[Article]>?
        
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
    
    func testSectionItems() {
        let exp: XCTestExpectation = expectation(description: "wait testSectionItems")
        var sec: [CategoriesViewModel.Section]?
        
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
    
    func testSourceItems() {
        let exp: XCTestExpectation = expectation(description: "wait testSourceItems")
        var articleItems: [Article]?
        
        viewModel.output.loadingState.subscribe(onNext: { state in
            switch state {
            case let .success(articles):
                articleItems = articles
            default:
                articleItems = nil
            }
            exp.fulfill()
        })
            .disposed(by: disposeBag)
        
        wait(for: [exp], timeout: 5)
    
        XCTAssertNotNil(articleItems)
        XCTAssertEqual(articleItems?.count, 20)
    }
    
    func testShowArticleDetail() {
        let observer = scheduler.createObserver(Step.self)
        
        guard let articles = ArticlesModelTest(jsonFile: .articleData) else {
            XCTFail("expected article model not to be nil")
            return
        }
        
        if let randomItem = articles.articles.randomElement() {
            
            scheduler.scheduleAt(0) {
                self.subscription = self.viewModel.steps.subscribe(observer)
            }
            scheduler.start()
            
            let article = Article(articleModel: randomItem)
            
            viewModel.input.showArticleDetail.execute(article)
            
            let result = observer.events.first.map {
                $0.value.element
            }
            
            let appStepResult = result as? AppSteps
            XCTAssertNotNil(appStepResult)
            
            switch appStepResult {
            case let .articleDetail(article):
                XCTAssertNotNil(article)
            default:
                XCTFail("expected testShowArticleDetail step")
            }
        }
    }
}
