//
//  CategoriesViewModel.swift
//  FastNews
//
//  Created by Serhan Khan on 29/09/2021.
//

import RxFlow
import RxCocoa
import RxSwift
import Action

class CategoriesViewModel: ViewModelType, Stepper {
    let steps = PublishRelay<Step>()
    
    struct Input {
        let selectedCategoryType: Action<Int, Void>
    }
    
    struct Output {
        let categoryTypes: Driver<[CustomSegmentItem]>
        let selectedCategoryType: Driver<CategoryType>
    }
    
    var input: Input { return internalInput }
    var outPut: Output { return internalOutput }
    
    private var internalInput: Input!
    private var internalOutput: Output!
    private let categoryService: CategoryServiceType!
    private let reachabilityService: ReachabilityServiceType
    private let categoryTypes = BehaviorRelay<[CustomSegmentItem]>(value: [])
    private let selectedCategoryType = BehaviorRelay<CategoryType>(value: .business)
    private let disposeBag = DisposeBag()
    
    init(reachabilityService: ReachabilityServiceType, categoryService: CategoryServiceType) {
        self.reachabilityService = reachabilityService
        self.categoryService = categoryService
        selectedCategoryType.asDriver().drive(onNext: topHeadLines).disposed(by: disposeBag)
        internalOutput = Output(categoryTypes: categoryTypes.asDriver(), selectedCategoryType: selectedCategoryType.asDriver())
        internalInput = Input(selectedCategoryType: createSelectCategoryAction())
        categoryTypes.accept(createCategoryTypes(selectedItem: selectedCategoryType.value))
        
    }
    
    private func createCategoryTypes(selectedItem: CategoryType) -> [CustomSegmentItem] {
        return CategoryType.allCases.map({ item -> CustomSegmentItem in
            if item == selectedItem {
                self.selectedCategoryType.accept(selectedItem)
                return CustomSegmentItem(title: item.title, isSelected: true)
            } else {
                return CustomSegmentItem(title: item.title, isSelected: false)
            }
        })
    }
    
    private func createSelectCategoryAction() -> Action<Int, Void> {
        return Action<Int, Void>(workFactory: {[weak self] index in
            return Observable.create { observer in
                if let strongSelf = self, let selectedItem = CategoryType.allCases.first(where: { $0.index == index }) {
                    strongSelf.categoryTypes.accept(strongSelf.createCategoryTypes(selectedItem: selectedItem))
                }
                observer.onCompleted()
                return Disposables.create()
            }
        })
    }
    
    private func topHeadLines(categoryType: CategoryType) {
        categoryService.topHeadLines(categoryType, "en")
            .subscribe(onNext: {
                print("Items:\($0)")
            })
            .disposed(by: disposeBag)
    }
}
