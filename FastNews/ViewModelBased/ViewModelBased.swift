//
//  ViewModelBased.swift
//  FastNews
//
//  Created by Serhan Khan on 23/09/2021.
//

import Foundation
import UIKit
import SwiftUI

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

extension ViewModelBased where Self: UIView {
    static func instantiate(with viewModel: ViewModelType) -> Self {
        let view = Self.init()
        view.viewModel = viewModel
        return view
    }
}

extension View {
    var hostingController: UIViewController {
        let hostingController = UIHostingController(rootView: self)
        return hostingController
    }
}
