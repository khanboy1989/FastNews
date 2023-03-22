//
//  PostDetailViewModel.swift
//  FastNews
//
//  Created by Serhan Khan on 20.03.23.
//

import RxFlow
import RxCocoa
import RxSwift
import Action
import Differentiator
import Combine

class PostDetailViewModel: ViewModelType, Stepper, ObservableObject {
    let steps = PublishRelay<Step>()
    
    var input: Input { return internalInput }
    var output: Output { return internalOutput }
    
    struct Input {
        let navigateBack: CocoaAction
        let navigateToStoryBoarded: CocoaAction
    }
    
    struct Output {
        let title: String
    }
    
    private var internalInput: Input!
    private var internalOutput: Output!
    private let postStorageService: PostStorageServiceType
    
    init(postStorageService: PostStorageServiceType) {
        self.postStorageService = postStorageService
        internalInput = Input(navigateBack: createNavigateBackAction(), navigateToStoryBoarded: createNavigateToStoryBoarded())
        internalOutput = Output(title: Localizable.Post.postDetailTitle.localized)
    }
    
    private func createNavigateBackAction() -> CocoaAction {
        return CocoaAction { [unowned self] in
            return Observable.create({ observer in
                self.steps.accept(AppSteps.didFinishPostDetail)
                observer.onCompleted()
                return Disposables.create()
            })
        }
    }
    
    private func createNavigateToStoryBoarded() -> CocoaAction {
        return CocoaAction { [unowned self] in
            return Observable.create( { observer in
                
                observer.onCompleted()
                return Disposables.create()
            })
        }
    }
    
}
