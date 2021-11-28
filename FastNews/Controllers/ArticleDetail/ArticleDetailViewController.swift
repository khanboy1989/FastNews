//
//  ArticleDetailViewController.swift
//  FastNews
//
//  Created by Serhan Khan on 10/11/2021.
//

import Foundation
import UIKit
import WebKit
import RxSwift

final class ArticleDetailViewController: UIViewController, StoryboardBased, ViewModelBased {
    
    var viewModel: ArticleDetailViewModel!
    private var disposeBag = DisposeBag()
    
    @IBOutlet private weak var webView: WKWebView!
    @IBOutlet private weak var loadingIndicator: UIActivityIndicatorView!{
        willSet {
            newValue.color = ColorTheme.black.color
            newValue.hidesWhenStopped = true
            newValue.isHidden = true
        }
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        bindViewModel()
        webView.isHidden = true
        webView.navigationDelegate = self
    }
    
    private func bindViewModel() {
        title = viewModel.output.title
        viewModel.output.navigation.drive(onNext: { [weak self] navigation in
            guard let request = navigation.request else {
                return
            }
            self?.webView.load(request)
            self?.loadingIndicator.startAnimating()
        })
            .disposed(by: disposeBag)
        
    }
}
extension ArticleDetailViewController: WKNavigationDelegate {
    
    func webView(_ webView: WKWebView, didFinish navigation: WKNavigation!) {
        loadingIndicator.stopAnimating()
        self.webView.isHidden = false
    }
    
    func webView(_ webView: WKWebView, didFail navigation: WKNavigation!, withError error: Error) {
        loadingIndicator.stopAnimating()
        self.webView.isHidden = false 
    }
}
