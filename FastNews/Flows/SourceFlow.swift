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
    
    private var rootViewController = SourcesViewController.instantiate()
    private let resolver: Dependencies
    
    init(with resolver: Dependencies, sourceStepper: SourceStepper) {
        self.resolver = resolver
    }
    
    func navigate(to step: Step) -> FlowContributors {
        guard let step = step as? AppSteps else { return .none }
        
        switch step {
        case .sources:
            return navigateToSources()
        default:
            return .none
        }
    }
    
    private func navigateToSources() -> FlowContributors {
        rootViewController.viewModel = resolver.resolve(SourcesViewModel.self)
        return .none
    }
    
}

class SourceStepper: Stepper {
    let steps = PublishRelay<Step>()
    
    var initialStep: Step {
        return AppSteps.sources
    }
}
