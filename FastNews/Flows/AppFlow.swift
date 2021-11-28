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
            return navigateToMain()
        default:
            return .none
        }
    }
    
    func navigateToMain() -> FlowContributors {
        let mainFlow = MainFlow(withResolve: resolver)
        let mainStepper = OneStepper(withSingleStep: AppSteps.main)
        let nextStepper = CompositeStepper(steppers: [mainStepper])
        
        Flows.use(mainFlow, when: .ready) {[unowned self] (root) in
            self.rootWindow.rootViewController = root
        }
        
        return .one(flowContributor: .contribute(withNextPresentable: mainFlow, withNextStepper: nextStepper))
    }

}
