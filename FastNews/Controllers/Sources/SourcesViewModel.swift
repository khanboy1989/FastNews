//
//  SourcesViewModel.swift
//  FastNews
//
//  Created by Serhan Khan on 29/09/2021.
//

import RxFlow
import RxCocoa
import RxSwift
import Action

class SourcesViewModel: ViewModelType, Stepper {
    let steps = PublishRelay<Step>()
    
    struct Input {}
    struct Output {}
    
    var input: Input { return internalInput }
    var outPut: Output { return internalOutput }
    
    private var internalInput: Input!
    private var internalOutput: Output!
    private let reachabilityService: ReachabilityServiceType
    private let disposeBag = DisposeBag()
    
    init(reachabilityService: ReachabilityServiceType) {
        self.reachabilityService = reachabilityService
    }
}
