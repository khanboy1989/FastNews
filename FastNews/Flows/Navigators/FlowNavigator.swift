//
//  FlowNavigator.swift
//  FastNews
//
//  Created by Serhan Khan on 28/09/2021.
//

import Foundation
import RxFlow

enum FlowNavigatorResult {
    case appStep(AppSteps)
    case nexFlowContributors(FlowContributors)
}

protocol FlowNavigator {
    func navigate(to step: Step) -> FlowNavigatorResult
}
