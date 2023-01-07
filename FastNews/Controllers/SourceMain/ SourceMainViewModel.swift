//
//  SourceMainViewModel.swift
//  FastNews
//
//  Created by Serhan Khan on 09/01/2022.
//

import RxFlow
import RxCocoa
import RxSwift
import Action
import Foundation

class SourceMainViewModel: ViewModelType, Stepper {
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
    private let source: Source
    init(reachability: ReachabilityServiceType, source: Source) {
        self.reachability = reachability
        self.source = source
        
        if let url = URL(string: source.url) {
            let navigation = Driver.just(url).map({ url -> Navigation in
                return Navigation(request: URLRequest(url: url))
            })
            
            internalOutput = Output(navigation: navigation, title: source.name)
        } else {
            internalOutput = Output(navigation: Driver.just(Navigation(request: nil)), title: source.name)
        }
    }
    
}
