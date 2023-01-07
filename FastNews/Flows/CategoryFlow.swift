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
    
    private let rootViewController: CategoriesViewController
    private let mainNavigationController: DefaultStyleNavigationController
    private let resolver: Dependencies
    
    init(with resolver: Dependencies,
         mainNavigationController: DefaultStyleNavigationController,
         categoryStepper: CategoryStepper) {
        self.resolver = resolver
        self.rootViewController = CategoriesViewController.instantiate()
        self.mainNavigationController = mainNavigationController
    }
    
    func navigate(to step: Step) -> FlowContributors {
        guard let step = step as? AppSteps else { return .none }
        switch step {
        case .categories:
            return navigateToCategories()
        case let .articleDetail(article):
            return navigateToArticleDetails(article: article)
        default:
            return .none
        }
    }
    
    private func navigateToCategories() -> FlowContributors {
        self.rootViewController.viewModel = resolver.resolve(CategoriesViewModel.self)
        let nextStepper = CompositeStepper(steppers: [rootViewController.viewModel])
        return .one(flowContributor: .contribute(withNextPresentable: rootViewController, withNextStepper: nextStepper))
    }
    
    private func navigateToArticleDetails(article: Article) -> FlowContributors {
        let viewController = ArticleDetailViewController.instantiate()
        viewController.viewModel = resolver.resolve(ArticleDetailViewModel.self, argument: article)
        let nextStepper = CompositeStepper(steppers: [viewController.viewModel])
        mainNavigationController.setNavigationBarHidden(false, animated: false)
        mainNavigationController.pushViewController(viewController, animated: true)
        return .one(flowContributor: .contribute(withNextPresentable: rootViewController, withNextStepper: nextStepper))
    }
    
}

class CategoryStepper: Stepper {
    let steps = PublishRelay<Step>()
    
    var initialStep: Step {
        return AppSteps.categories
    }
}
