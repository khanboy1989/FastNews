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
            print("Result = \($0)")
            switch $0 {
            case .loading:
                self.loadingIndicator.isHidden = false
                self.loadingIndicator.startAnimating()
                
                break
//                            DispatchQueue.main.async {
//                                SVProgressHUD.show()
//                            }
            case let .error (error):
                self.loadingIndicator.stopAnimating()
                break
            case .success:
                break
            }
            
        })
            .disposed(by: disposeBag)
        
        viewModel.output.sections
            .do(onNext: {
            [weak self] sections in
                self?.loadingIndicator.stopAnimating()
            
        }).drive(tableView.rx.items(dataSource: dataSource))
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
