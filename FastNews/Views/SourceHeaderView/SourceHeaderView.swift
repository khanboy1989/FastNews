//
//  SourceHeaderView.swift
//  FastNews
//
//  Created by Serhan Khan on 09/01/2022.
//

import Foundation
import UIKit
import RxSwift
import RxCocoa
import Action

class SourceHeaderView: UIView, NibOwnerLoadable {
    
    @IBOutlet private weak var searchBar: UISearchBar!
    private let searchTermOverride = PublishSubject<String?>()
    private var disposeBag = DisposeBag()
    
    lazy var searchTerm: Driver<String?> = {
        return Observable<String?>
            .merge([searchTermOverride.asObservable(), searchBar.rx.text.asObservable()])
            .distinctUntilChanged()
            .asDriver(onErrorJustReturn: nil)
    }()
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        loadNibContent()
        updateUI()
        sharedInit()
    }

    required init?(coder: NSCoder) {
        super.init(coder: coder)
        loadNibContent()
        updateUI()
        sharedInit()
    }
    
    private func sharedInit() {
        configureRx()
    }
    
    private func updateUI() {
        backgroundColor = ColorTheme.appBackground.color
        searchBar.setBackgroundImage(UIImage(), for: .any, barMetrics: .default)
        searchBar.searchTextField.leftView?.tintColor = .black
        searchBar.tintColor = .black
        searchBar.searchTextField.textColor = .black
        searchBar.searchTextField.clearButtonTintColor = .black
        searchBar.searchTextField.attributedPlaceholder = NSAttributedString.init(string: "Search for news source", attributes: [NSAttributedString.Key.foregroundColor: UIColor.black])
    }
    
    private func configureRx() {
        searchBar.rx.searchButtonClicked
            .bind(onNext: { [weak self] in
                self?.searchBar.resignFirstResponder()
            })
            .disposed(by: disposeBag)
        
        searchTermOverride
            .bind(to: searchBar.rx.text)
            .disposed(by: disposeBag)
    }
}
