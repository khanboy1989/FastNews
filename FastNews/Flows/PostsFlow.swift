//
//  PostsFlow.swift
//  FastNews
//
//  Created by Serhan Khan on 06.01.23.
//

import Foundation
import RxFlow
import RxCocoa

class PostsFlow: Flow {
    
    var root: Presentable {
        return self.rootViewController
    }
    
    private var rootViewController: PostsViewController
    private let mainNavigationController: DefaultStyleNavigationController
    private let resolver: Dependencies
    
    init(with resolver: Dependencies,
         mainNavigationController: DefaultStyleNavigationController,
         postsStepper: PostsStepper) {
        self.resolver = resolver
        self.rootViewController = PostsViewController.instantiate()
        self.mainNavigationController = mainNavigationController
    }
    
    func navigate(to step: Step) -> FlowContributors {
        guard let step = step as? AppSteps else { return .none }
        switch step {
        case .posts:
            return navigateToPosts()
        default:
            return .none
        }
    }
    
    private func navigateToPosts() -> FlowContributors {
        rootViewController.viewModel = resolver.resolve(PostsViewModel.self)
        let nextStepper = CompositeStepper(steppers: [rootViewController.viewModel])
        return .one(flowContributor: .contribute(withNextPresentable: rootViewController, withNextStepper: nextStepper))
    }
}


class PostsStepper: Stepper {
    let steps = PublishRelay<Step>()
    
    var initialStep: Step {
        return AppSteps.posts
    }
}
