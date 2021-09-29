//
//  MainNavigator.swift
//  FastNews
//
//  Created by Serhan Khan on 28/09/2021.
//

import Foundation
import RxFlow
import RxSwift

class MainNavigator: FlowNavigator {
    
    private let disposeBag = DisposeBag()
    private let mainTabBarController: UITabBarController
    
    private var currentSubFlow: MainFlow.SubFlow? {
        let tabIndex = mainTabBarController.selectedIndex
        return MainFlow.SubFlow(rawValue: tabIndex)
    }
    
    // Steppers
    private let categoryStepper: Stepper
    private let sourceStepper: Stepper
    
    init(mainTabBarController: UITabBarController,
         categoryStepper: Stepper,
         sourceStepper: Stepper) {
        self.mainTabBarController = mainTabBarController
        self.categoryStepper = categoryStepper
        self.sourceStepper = sourceStepper
        
    }
    
    func navigate(to step: Step) -> FlowNavigatorResult {
        return .nexFlowContributors(.none)
    }
    
}
