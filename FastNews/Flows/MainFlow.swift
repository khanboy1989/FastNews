//
//  MainFlow.swift
//  FastNews
//
//  Created by Serhan Khan on 28/09/2021.
//

import Foundation
import RxFlow
import RxSwift
import UIKit

class MainFlow: Flow {
    
    enum SubFlow: Int {
        case categories = 0
        case sources = 1
        case posts = 2
    }
    
    var root: Presentable {
        return rootViewController
    }
    
    private let rootViewController: DefaultStyleNavigationController
    private let tabbarViewController: TabBarController
    private let resolver: Dependencies
    private let disposeBag = DisposeBag()
    private let categoryStepper = CategoryStepper()
    private let sourceStepper = SourceStepper()
    private let postsStepper = PostsStepper()

    init(withResolve resolver: Dependencies) {
        self.resolver = resolver
        self.rootViewController = DefaultStyleNavigationController()
        self.tabbarViewController = TabBarController.instantiate()
        self.tabbarViewController.viewModel = resolver.resolve(TabBarViewModel.self)
        self.rootViewController.viewControllers = [tabbarViewController]
    }
    
    func navigate(to step: Step) -> FlowContributors {
        guard let step = step as? AppSteps else { return .none }
        switch step {
        case .main:
            return navigateToHome()
        default:
            return .none
        }
    }
    
    private func navigateToHome() -> FlowContributors {
        
        let categoryFlow = CategoryFlow(with: resolver, mainNavigationController: rootViewController, categoryStepper: categoryStepper)
        
        let sourceFlow = SourceFlow(with: resolver, mainNavigationController: rootViewController, sourceStepper: sourceStepper)
        
        let postsFlow = PostsFlow(with: resolver, mainNavigationController: rootViewController, postsStepper: postsStepper)
        
        Flows.use(categoryFlow, sourceFlow, postsFlow, when: .ready, block: {( root1: UIViewController, root2: UIViewController, root3: UIViewController) in
            root1.tabBarItem = UITabBarItem(title: nil, image: Asset.Image.homeIcon.originalImage, selectedImage: Asset.Image.homeIconSelected.originalImage)
            root2.tabBarItem = UITabBarItem(title: nil, image: Asset.Image.sourcesIcon.originalImage, selectedImage: Asset.Image.sourcesIconSelected.originalImage)
            root3.tabBarItem = UITabBarItem(title: nil, image: Asset.Image.sourcesIcon.originalImage, selectedImage: Asset.Image.sourcesIconSelected.originalImage)
            
            self.tabbarViewController.setViewControllers([root1, root2, root3], animated: true)
        })
        
        let categoryFlowContributor: FlowContributor = .contribute(withNextPresentable: categoryFlow, withNextStepper: categoryStepper)
        
        let sourceFlowContributor: FlowContributor = .contribute(withNextPresentable: sourceFlow, withNextStepper: sourceStepper)
        
        let postsFlowContributor: FlowContributor = .contribute(withNextPresentable: postsFlow, withNextStepper: postsStepper)
        
        let flowContributors: [FlowContributor] = [categoryFlowContributor, sourceFlowContributor, postsFlowContributor]
        
        return .multiple(flowContributors: flowContributors)
    }
    
}
