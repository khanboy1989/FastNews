//
//  CategoryStepper.swift
//  FastNews
//
//  Created by Serhan Khan on 29/09/2021.
//

import Foundation
import RxFlow
import RxCocoa

class CategoryFlow: Flow {
    
    var root: Presentable {
        return self.rootViewController
    }
    
    private var rootViewController = CategoriesViewController.instantiate()
    private let resolver: Dependencies
    
    init(with resolver: Dependencies, categoryStepper: CategoryStepper) {
        self.resolver = resolver
    }
    
    func navigate(to step: Step) -> FlowContributors {
        guard let step = step as? AppSteps else { return .none }
        
        switch step {
        case .categories:
            return navigateToCategories()
        default:
            return .none
        }
    }
    
    private func navigateToCategories() -> FlowContributors {
        rootViewController.viewModel = resolver.resolve(CategoriesViewModel.self)
        return .none
    }
    
}

class CategoryStepper: Stepper {
    let steps = PublishRelay<Step>()
    
    var initialStep: Step {
        return AppSteps.categories
    }
}
