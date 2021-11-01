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
    @IBOutlet private weak var tableView: UITableView!
    
    var viewModel: CategoriesViewModel!
    private let disposeBag = DisposeBag()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        bindViewModel()
        tableView.register(cellType: ArticleTableViewCell.self)
    }
    
    private func bindViewModel() {
        viewModel.output.categoryTypes.drive(onNext: customSegmentsView.setItems)
            .disposed(by: disposeBag)
        
        customSegmentsView.onWillChangeSelectedIndex = {[weak self] index in
            self?.viewModel.input.selectedCategoryType.execute(index)
        }
        
        viewModel.output.loadingState.subscribe(onNext: {
            print("Result = \($0)")
        })
            .disposed(by: disposeBag)
    
    }
    
    private func configureCell() {
        
    }

}
