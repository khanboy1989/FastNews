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

class ArticleDetailViewModel: ViewModelType, Stepper {
    
    let steps = PublishRelay<Step>()
    
    struct Input {}
    struct Output {
        let urlToResource: String?
    }
    
    var input: Input { return internalInput }
    var output: Output { return internalOutput }
    
    private var internalInput: Input!
    private var internalOutput: Output!
    private let reachability: ReachabilityServiceType
    private let article: Article
    
    init(reachability: ReachabilityServiceType, article: Article) {
        self.reachability = reachability
        self.article = article
        
        internalOutput = Output(urlToResource: article.url)
    }
    
}
