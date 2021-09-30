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
    }
    
    var root: Presentable {
        return rootViewController
    }
    
    private let rootViewController: TabBarController
    private let resolver: Dependencies
    private let disposeBag = DisposeBag()
    private let categoryStepper = CategoryStepper()
    private let sourceStepper = SourceStepper()
    
    init(withResolve resolver: Dependencies) {
        self.resolver = resolver
        self.rootViewController = TabBarController.instantiate()
        self.rootViewController.viewModel = resolver.resolve(TabBarViewModel.self)
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
        
        let categoryFlow = CategoryFlow(with: resolver)
        let sourceFlow = SourceFlow(with: resolver)
        
        Flows.use(categoryFlow, sourceFlow, when: .ready, block: {( root1: UIViewController, root2: UIViewController ) in
            root1.tabBarItem = UITabBarItem(title: "Categories", image: nil, selectedImage: nil)
            root2.tabBarItem = UITabBarItem(title: "Sources", image: nil, selectedImage: nil)
            self.rootViewController.setViewControllers([root1, root2], animated: true)
        })
        
        let categoryFlowContributor: FlowContributor = .contribute(withNextPresentable: categoryFlow, withNextStepper: categoryStepper)
        
        let sourceFlowContributor: FlowContributor = .contribute(withNextPresentable: sourceFlow, withNextStepper: sourceStepper)
        
        let flowContributors: [FlowContributor] = [categoryFlowContributor, sourceFlowContributor]
        
        return .multiple(flowContributors: flowContributors)
    }
    
}
