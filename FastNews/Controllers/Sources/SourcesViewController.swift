//
//  SourcesViewController.swift
//  FastNews
//
//  Created by Serhan Khan on 29/09/2021.
//

import Foundation
import UIKit
import RxSwift
import RxDataSources

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
    
    private typealias DataSource = RxTableViewSectionedReloadDataSource<SourcesViewModel.Section>
    private typealias ConfigureCell = (TableViewSectionedDataSource<SourcesViewModel.Section>, UITableView, IndexPath, SourcesViewModel.Item) -> UITableViewCell
    private var dataSource: DataSource!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        configureTableView()
        bindViewModel()
    }
    
    private func configureTableView() {
        tableView.register(cellType: SourceTableViewCell.self)
        tableView.rowHeight = UITableView.automaticDimension
        tableView.separatorStyle = .none
        tableView.showsVerticalScrollIndicator = false
        dataSource = DataSource(configureCell: configureCell())
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
            case .success:
                self.loadingIndicator.stopAnimating()
            }
        })
            .disposed(by: disposeBag)
        
        viewModel.output.sections
         .drive(tableView.rx.items(dataSource: dataSource))
         .disposed(by: disposeBag)
        
        viewModel.input.sources.execute()
        
        
    }
    
    private func configureCell() -> ConfigureCell {
        return { (_, tableView, indexPath, item) -> UITableViewCell in
            let cell: UITableViewCell
            switch item {
            case let .source(source):
                let sourceCell: SourceTableViewCell = tableView.dequeueReusableCell(for: indexPath)
                sourceCell.source = source
                sourceCell.selectionStyle = .none
                cell = sourceCell
            }
            return cell
        }
    }
}
