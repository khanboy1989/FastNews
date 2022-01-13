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
    struct Output {}
    
    var input: Input { return internalInput }
    var output: Output { return internalOutput }
    
    private var internalInput: Input!
    private var internalOutput: Output!
    private let reachability: ReachabilityServiceType
    
    init(reachability: ReachabilityServiceType, source: Source) {
        self.reachability = reachability
    }
    
}
