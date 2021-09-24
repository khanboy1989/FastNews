//
//  ViewController.swift
//  FastNews
//
//  Created by Serhan Khan on 21/09/2021.
//

import UIKit
import RxSwift

class ViewController: UIViewController, StoryboardBased, ViewModelBased {
    var viewModel: ViewModel!

    override func viewDidLoad() {
        super.viewDidLoad()
        view.backgroundColor = .white
        viewModel.input.testAction.execute("String test")
    }
}
