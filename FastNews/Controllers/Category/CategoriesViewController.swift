//
//  ViewController.swift
//  FastNews
//
//  Created by Serhan Khan on 21/09/2021.
//

import UIKit
import RxSwift

class CategoriesViewController: UIViewController, StoryboardBased, ViewModelBased {
    
    @IBOutlet private weak var customSegmentsView: CustomSegmentsView!
   
    var viewModel: CategoriesViewModel!
    private let disposeBag = DisposeBag()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        bindViewModel()
    }
    
    private func bindViewModel() {
        viewModel.outPut.categoryTypes.drive(onNext: customSegmentsView.setItems)
            .disposed(by: disposeBag)
        
        customSegmentsView.onWillChangeSelectedIndex = {[weak self] index in
            self?.viewModel.input.selectedCategoryType.execute(index)
        }
    }
}
