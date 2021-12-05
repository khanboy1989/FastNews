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
import Differentiator

class SourcesViewModel: ViewModelType, Stepper {
    typealias SourcesLoadingState = LoadingState<[Source]>
    let steps = PublishRelay<Step>()
    
    struct Input {
        let sources: Action<Void, Void>
    }
    struct Output {
        let loadingState: BehaviorRelay<SourcesLoadingState>
        let sections: Driver<[Section]>
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
        
        internalOutput = Output(loadingState: sourcesLoadingState, sections: createSections(loadingState: sourcesLoadingState.asObservable()).asDriver(onErrorJustReturn: []))
        
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
    
    private func createSections(loadingState: Observable<SourcesLoadingState>) -> Observable<[Section]> {
        return loadingState.debounce(.milliseconds(100), scheduler: MainScheduler.instance)
            .map({ state -> [Section] in
                var sections = [Section]()
                switch state {
                case let .success(sources):
                    let items = sources.map({
                        Item.source($0)
                    })
                    sections.append(.sources(items: items))
                    return sections
                default:
                    return sections
                }
            })
    }
    
    enum Item: IdentifiableType {
        case source(Source)
        
        var identity: String {
            switch self {
            case let .source(source):
                return "source-\(source.name)"
            }
        }
    }
    
    enum Section: SectionModelType {
        case sources(items: [Item])
        
        var identity: Int {
            switch self {
            case .sources:
                return 0
            }
        }
        
        var items: [Item] {
            switch self {
            case let .sources(items: items):
                return items
            }
        }
        
        init(original: SourcesViewModel.Section, items: [SourcesViewModel.Item]) {
            switch original {
            case .sources:
                self = .sources(items: items)
            }
        }
    }
}
