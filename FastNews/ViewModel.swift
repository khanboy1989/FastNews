//
//  ViewModel.swift
//  FastNews
//
//  Created by Serhan Khan on 23/09/2021.
//

import Foundation
import RxFlow
import RxCocoa
import RxSwift
import Action

final class ViewModel: ViewModelType, Stepper {
    let steps = PublishRelay<Step>()
    
    var input: Input { return internalInput }
    var output: Output { return internalOutput }
    
    struct Input {
        let testAction: Action<String, Void>
    }
    
    struct Output {}
    
    private var internalInput: Input!
    private var internalOutput: Output!
    private let reachabilityService: ReachabilityServiceType

    init(reachabilityService: ReachabilityServiceType) {
        self.reachabilityService = reachabilityService
        let testAction = createTestAction()
        internalInput = Input(testAction: testAction)
        internalOutput = Output()
    }
    
    private func createTestAction() -> Action<String, Void> {
        return Action(workFactory: {string in
            return Observable.create({ observer in
                print("Observed string:\(string)")
                observer.onCompleted()
                return Disposables.create()
            })
        })
    }
}
