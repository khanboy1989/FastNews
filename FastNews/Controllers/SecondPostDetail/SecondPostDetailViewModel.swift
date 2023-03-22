//
//  SecondPostDetailViewModel.swift
//  FastNews
//
//  Created by Serhan Khan on 21.03.23.
//

import Foundation
import RxFlow
import RxSwift
import RxCocoa


class SecondPostDetailViewModel: ViewModelType, Stepper {
    
    let steps = PublishRelay<Step>()
    
    struct Input {
        
    }
    struct Output {
        let title: String
    }
    
    var input: Input { return internalInput }
    var output: Output { return internalOutput }
    
    private var internalInput: Input!
    private var internalOutput: Output!
    private let postStorageService: PostStorageServiceType
    
    init(postStorageService: PostStorageServiceType) {
        self.postStorageService = postStorageService
        internalInput = Input()
        internalOutput = Output(title: Localizable.Post.postDetailTitle.localized)
    }
}
