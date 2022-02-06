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
    private let disposeBag = DisposeBag()
    
    override func setUpWithError() throws {
        scheduler = TestScheduler(initialClock: 0)
        createCategoriesViewModel()
    }
    
    private func createCategoriesViewModel() {
        viewModel = CategoriesViewModel(reachabilityService: ReachabilityServiceMock(), categoryService: CategoryServiceMock())
    }
    
    func testSectionItems() {
        
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
        let exp: XCTestExpectation = expectation(description: "wait testSelectedCategoryType")
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
    
}
