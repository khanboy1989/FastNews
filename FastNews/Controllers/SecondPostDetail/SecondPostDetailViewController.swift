//
//  SecondPostDetailViewController.swift
//  FastNews
//
//  Created by Serhan Khan on 21.03.23.
//

import Foundation
import RxSwift
import UIKit

class SecondPostDetailViewController: UIViewController, ViewModelBased, StoryboardBased {
    
    var viewModel: SecondPostDetailViewModel!
    private var disposeBag = DisposeBag()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        title = viewModel.output.title
    }
    
}
