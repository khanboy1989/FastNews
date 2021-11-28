//
//  ArticleDetailViewModel.swift
//  FastNews
//
//  Created by Serhan Khan on 10/11/2021.
//

import RxFlow
import RxCocoa
import RxSwift
import Action
import Foundation

class ArticleDetailViewModel: ViewModelType, Stepper {
    
    let steps = PublishRelay<Step>()
    
    struct Input {}
    struct Output {
        let navigation: Driver<Navigation>
        let title: String?
    }
    
    struct Navigation {
        let request: URLRequest?
    }
    
    var input: Input { return internalInput }
    var output: Output { return internalOutput }
    
    private var internalInput: Input!
    private var internalOutput: Output!
    private let reachability: ReachabilityServiceType
    private let article: Article
    
    init(reachability: ReachabilityServiceType,
         article: Article) {
        self.reachability = reachability
        self.article = article
        
        if let stringUrl = article.url, let url = URL(string: stringUrl) {
            let navigation = Driver.just(url).map({ url -> Navigation in
                return Navigation(request: URLRequest(url: url))
            })
            internalOutput = Output(navigation: navigation, title: article.title)
        } else {
            internalOutput = Output(navigation: Driver.just(Navigation(request: nil)), title: article.title)
        }
    }
}
