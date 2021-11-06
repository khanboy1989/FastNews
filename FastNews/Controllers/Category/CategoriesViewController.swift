//
//  ViewController.swift
//  FastNews
//
//  Created by Serhan Khan on 21/09/2021.
//

import UIKit
import RxSwift
import RxDataSources

class CategoriesViewController: UIViewController, StoryboardBased, ViewModelBased {
    
    @IBOutlet private weak var customSegmentsView: CustomSegmentsView!
    @IBOutlet private weak var tableView: UITableView!
    @IBOutlet private weak var loadingIndicator: UIActivityIndicatorView! {
        willSet {
            newValue.color = ColorTheme.black.color
            newValue.hidesWhenStopped = true
            newValue.isHidden = true
        }
    }
    
    private typealias DataSource = RxTableViewSectionedReloadDataSource<CategoriesViewModel.Section>
    private typealias ConfigureCell = (TableViewSectionedDataSource<CategoriesViewModel.Section>, UITableView, IndexPath, CategoriesViewModel.Item) -> UITableViewCell
    
    var viewModel: CategoriesViewModel!
    private let disposeBag = DisposeBag()
    private var dataSource: DataSource!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        configureTableView()
        bindViewModel()
    }
    
    private func configureTableView() {
        tableView.register(cellType: ArticleTableViewCell.self)
        tableView.rowHeight = UITableView.automaticDimension
        tableView.separatorStyle = .none
        tableView.contentInsetAdjustmentBehavior = .never
        dataSource = DataSource(configureCell: configureCell())
    }
    
    private func bindViewModel() {
       
        viewModel.output.categoryTypes.drive(onNext: customSegmentsView.setItems)
            .disposed(by: disposeBag)
        
        customSegmentsView.onWillChangeSelectedIndex = {[weak self] index in
            self?.viewModel.input.selectedCategoryType.execute(index)
        }
        
        viewModel.output.loadingState
            .subscribe(onNext: {
            switch $0 {
            case .loading:
                self.loadingIndicator.isHidden = false
                self.loadingIndicator.startAnimating()
            case let .error (_):
                self.loadingIndicator.stopAnimating()
            case .success:
                self.loadingIndicator.stopAnimating()
            }
        })
            .disposed(by: disposeBag)
        
        viewModel.output.sections
         .drive(tableView.rx.items(dataSource: dataSource))
         .disposed(by: disposeBag)
    
    }
    
    private func configureCell() -> ConfigureCell {
        return { (_, tableView, indexPath, item) -> UITableViewCell in
            let cell: UITableViewCell
            switch item {
            case let .headline(article):
                let articleCell: ArticleTableViewCell = tableView.dequeueReusableCell(for: indexPath)
                articleCell.article = article
                articleCell.selectionStyle = .none
                cell = articleCell
            }
            return cell
        }
    }

}
