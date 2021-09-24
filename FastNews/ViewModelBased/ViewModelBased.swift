//
//  ViewModelBased.swift
//  FastNews
//
//  Created by Serhan Khan on 23/09/2021.
//

import Foundation
import UIKit

protocol ViewModelBased: AnyObject {
    associatedtype ViewModelType
    var viewModel: ViewModelType! { get set }
}

extension ViewModelBased where Self: UIViewController & StoryboardBased {
    static func instantiate(with viewModel: ViewModelType) -> Self {
        let viewController = Self.instantiate()
        viewController.viewModel = viewModel
        return viewController
    }
}
