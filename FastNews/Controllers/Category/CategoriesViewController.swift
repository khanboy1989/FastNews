//
//  ViewController.swift
//  FastNews
//
//  Created by Serhan Khan on 21/09/2021.
//

import UIKit
import RxSwift

class CategoriesViewController: UIViewController, StoryboardBased, ViewModelBased {
    
    var viewModel: CategoriesViewModel!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        print("Categories did load")
    }
}
