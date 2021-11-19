//
//  ArticleDetailViewController.swift
//  FastNews
//
//  Created by Serhan Khan on 10/11/2021.
//

import Foundation
import UIKit

final class ArticleDetailViewController: UIViewController, StoryboardBased, ViewModelBased {
    
    var viewModel: ArticleDetailViewModel!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        bindViewModel()
    }
    
    private func bindViewModel() {
        
    }
}
