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
    typealias SourcesLoadingState = LoadingState<[Source]>
    let steps = PublishRelay<Step>()
    
    struct Input {
        let sources: Action<Void, Void>
    }
    struct Output {
        let loadingState: BehaviorRelay<SourcesLoadingState>
    }
    
    var input: Input { return internalInput }
    var output: Output { return internalOutput }
    
    private var internalInput: Input!
    private var internalOutput: Output!
    private let reachabilityService: ReachabilityServiceType
    private let disposeBag = DisposeBag()
    private let sourceServiceType: SourceServiceType
    private let defaultCountry: String = "us"
    private let sourcesLoadingState = BehaviorRelay
    <SourcesLoadingState>(value: .loading)
    private let sourceRequest = PublishSubject<Observable<SourcesLoadingState>>()
    
    init(reachabilityService: ReachabilityServiceType, sourceServiceType: SourceServiceType) {
        self.reachabilityService = reachabilityService
        self.sourceServiceType = sourceServiceType
        internalOutput = Output(loadingState: sourcesLoadingState)
        internalInput = Input(sources: createSourcesRequestAction())
    }
    
    private func createSourcesRequest() -> Observable<SourcesLoadingState> {
        return sourceServiceType.sources(defaultCountry)
            .asObservable()
            .map({ sources in
                return SourcesLoadingState.success(sources)
            })
            .catchError({ [unowned self] error -> Observable<SourcesLoadingState> in
                let result: SourcesLoadingState
                if self.reachabilityService.isAvailable == false {
                    result = .error(.noInternet)
                } else {
                    result = .error(.custom(error.localizedDescription))
                }
                return Observable.just(result)
            })
    }
    
    private func createSourcesRequestAction() -> Action<Void, Void> {
        return Action<Void, Void>(workFactory: {[unowned self]  in
            return Observable.create { observer in
                self.sourceRequest.do(onNext: { _ in
                    self.sourcesLoadingState.accept(.loading)
                })
                    .switchLatest()
                    .bind(to: self.sourcesLoadingState)
                    .disposed(by: disposeBag)
                    
                let sources = createSourcesRequest()
                sourceRequest.onNext(sources)
                observer.onCompleted()
                return Disposables.create()
            }
        })
    }
}
