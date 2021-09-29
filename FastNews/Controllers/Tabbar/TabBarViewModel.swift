//
//  TabBarViewModel.swift
//  FastNews
//
//  Created by Serhan Khan on 28/09/2021.
//

import RxSwift
import RxFlow
import RxCocoa

class TabBarViewModel: ViewModelType, Stepper {
    
    let steps = PublishRelay<Step>()
    
    struct Input {}
    struct Output {}
    
    var input: Input { return internalInput }
    var outPut: Output { return internalOutput }
    
    private var internalInput: Input!
    private var internalOutput: Output!
    
}
