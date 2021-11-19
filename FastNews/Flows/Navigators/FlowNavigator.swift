//
//  FlowNavigator.swift
//  FastNews
//
//  Created by Serhan Khan on 19/11/2021.
//

import Foundation
import RxFlow

enum FlowNavigatorResult {
    case appStep(AppSteps)
    case nextFlowContributors(FlowContributors)
}

protocol FlowNavigator {
    func navigate(to step: Step) -> FlowNavigatorResult
}
