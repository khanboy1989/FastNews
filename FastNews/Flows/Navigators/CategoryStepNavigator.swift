//
//  CategoryStepNavigator.swift
//  FastNews
//
//  Created by Serhan Khan on 19/11/2021.
//

import Foundation
import RxFlow

class CategoryStepNavigator: AppStepNavigator {
    
    func navigate(to appStep: AppSteps) -> FlowContributors? {
        switch appStep {
        case .articleDetail:
            return nagivateToArticleDetail()
        default:
            return nil 
        }
    }
    
    private func nagivateToArticleDetail() -> FlowContributors {
        print("Category detail tapped")
        return .none
    }
}
