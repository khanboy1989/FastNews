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

    @IBOutlet private weak var label: UILabel!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        view.backgroundColor = .white
        viewModel.input.testAction.execute("String test")
        
        label.textColor = .black
        label.font = UIFont.mediumFont(size: 24)
        label.text = "String test"
    }
}
