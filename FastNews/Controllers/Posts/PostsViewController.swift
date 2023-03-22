//
//  PostsViewController.swift
//  FastNews
//
//  Created by Serhan Khan on 06.01.23.
//

import Foundation
import UIKit
import RxSwift
import RxDataSources

class PostsViewController: UIViewController, StoryboardBased, ViewModelBased {
    
    var viewModel: PostsViewModel!
    private var disposeBag = DisposeBag()
    
    @IBOutlet private weak var tableView: UITableView!
    
    private typealias DataSource = RxTableViewSectionedReloadDataSource<PostsViewModel.Section>
    private typealias ConfigureCell = (TableViewSectionedDataSource<PostsViewModel.Section>, UITableView, IndexPath, PostsViewModel.Item) -> UITableViewCell
    private var dataSource: DataSource!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        configureTableView()
        bindViewModel()
    }
    
    private func bindViewModel() {
        viewModel.output.sections
         .drive(tableView.rx.items(dataSource: dataSource))
         .disposed(by: disposeBag)
        
        
        tableView.rx.itemSelected.subscribe(onNext: { [unowned self] indexPath in
            if let model = try? self.dataSource.model(at: indexPath) as? PostsViewModel.Item {
                switch model {
                case let .post(post):
                    self.viewModel.input.showPostDetail.execute(post)
                }
            }
            
        })
            .disposed(by: disposeBag)
    }
    
    private func configureTableView() {
        tableView.register(cellType: PostItemTableViewCell.self)
        tableView.rowHeight = UITableView.automaticDimension
        tableView.separatorStyle = .none
        tableView.showsVerticalScrollIndicator = false
        dataSource = DataSource(configureCell: configureCell())
    }
    
    private func configureCell() -> ConfigureCell {
        return { (_, tableView, indexPath, item) -> UITableViewCell in
            let cell: UITableViewCell
            switch item {
            case let .post(post):
                let sourceCell: PostItemTableViewCell = tableView.dequeueReusableCell(for: indexPath)
                sourceCell.post = post
                sourceCell.selectionStyle = .none
                cell = sourceCell
            }
            return cell
        }
    }
}
