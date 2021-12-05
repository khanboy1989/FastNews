//
//  SourcesViewController.swift
//  FastNews
//
//  Created by Serhan Khan on 29/09/2021.
//

import Foundation
import UIKit
import RxSwift

class SourcesViewController: UIViewController, StoryboardBased, ViewModelBased, Alertable {
    
    var viewModel: SourcesViewModel!
    private let disposeBag = DisposeBag()
    
    @IBOutlet private weak var loadingIndicator: UIActivityIndicatorView! {
        willSet {
            newValue.color = ColorTheme.black.color
            newValue.hidesWhenStopped = true
            newValue.isHidden = true
        }
    }
    
    @IBOutlet private weak var tableView: UITableView!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        bindViewModel()
    }
    
    private func bindViewModel() {
        viewModel.output.loadingState.subscribe(onNext: {
            switch $0 {
            case .loading:
                self.loadingIndicator.isHidden = false
                self.loadingIndicator.startAnimating()
            case let .error(error):
                self.loadingIndicator.isHidden = true
                self.showAlert(title: Localizable.General.error.localized, message: error.description)
            case let .success(_):
                self.loadingIndicator.stopAnimating()
            }
        })
            .disposed(by: disposeBag)
        viewModel.input.sources.execute()
    }
}
