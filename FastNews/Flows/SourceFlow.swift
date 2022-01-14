//
//  SourceFlow.swift
//  FastNews
//
//  Created by Serhan Khan on 29/09/2021.
//

import Foundation
import RxFlow
import RxCocoa

class SourceFlow: Flow {
    
    var root: Presentable {
        return self.rootViewController
    }
    
    private var rootViewController: SourcesViewController
    private let mainNavigationController: DefaultStyleNavigationController
    private let resolver: Dependencies
    
    init(with resolver: Dependencies,
         mainNavigationController: DefaultStyleNavigationController,
         sourceStepper: SourceStepper) {
        self.resolver = resolver
        self.rootViewController = SourcesViewController.instantiate()
        self.mainNavigationController = mainNavigationController
    }
    
    func navigate(to step: Step) -> FlowContributors {
        guard let step = step as? AppSteps else { return .none }
        switch step {
        case .sources:
            return navigateToSources()
        case let .sourceMain(source):
            return navigateToSourceMain(source: source)
        default:
            return .none
        }
    }
    
    private func navigateToSources() -> FlowContributors {
        rootViewController.viewModel = resolver.resolve(SourcesViewModel.self)
        let nextStepper = CompositeStepper(steppers: [rootViewController.viewModel])
        return .one(flowContributor: .contribute(withNextPresentable: rootViewController, withNextStepper: nextStepper))
    }
    
    private func navigateToSourceMain(source: Source) -> FlowContributors {
        let viewController = SourceMainViewController.instantiate()
        viewController.viewModel =  resolver.resolve(SourceMainViewModel.self, argument: source)
        let nextStepper = CompositeStepper(steppers: [viewController.viewModel])
        mainNavigationController.setNavigationBarHidden(false, animated: false)
        mainNavigationController.pushViewController(viewController, animated: true)
        return .one(flowContributor: .contribute(withNextPresentable: rootViewController, withNextStepper: nextStepper))
    }
    
}

class SourceStepper: Stepper {
    let steps = PublishRelay<Step>()
    
    var initialStep: Step {
        return AppSteps.sources
    }
}
