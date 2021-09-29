//
//  AppStepNavigator.swift
//  FastNews
//
//  Created by Serhan Khan on 28/09/2021.
//

import RxFlow

protocol AppStepNavigator {
    func navigate(to appStep: AppSteps) -> FlowContributors?
    func dismissPresented(presenter: UIViewController, animated: Bool) -> FlowContributors
}

extension AppStepNavigator {
    func dismissedPresented(presenter: UIViewController, animated: Bool) -> FlowContributors {
        presenter.presentedViewController?.dismiss(animated: animated)
        return .none
    }
}
