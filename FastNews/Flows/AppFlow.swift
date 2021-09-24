//
//  AppFlow.swift
//  FastNews
//
//  Created by Serhan Khan on 23/09/2021.
//

import Foundation
import UIKit
import RxFlow

class AppFlow: Flow {
    var root: Presentable {
        return self.rootWindow
    }
   
    private let rootWindow: UIWindow
    private let resolver: Dependencies
    
    init(with window: UIWindow, resolver: Dependencies) {
        self.rootWindow = window
        self.resolver = resolver
    }
    
    func navigate(to step: Step) -> FlowContributors {
        guard let step = step as? AppSteps else { return .none }
        switch step {
        case .initial:
            return navigateToViewController()
        }
    }
    
    func navigateToViewController() -> FlowContributors {
        let viewController = ViewController.instantiate()
        viewController.viewModel = resolver.resolve(ViewModel.self)
        rootWindow.rootViewController = viewController
        return .one(flowContributor: .contribute(withNextPresentable: viewController, withNextStepper: viewController.viewModel))
    }

}
