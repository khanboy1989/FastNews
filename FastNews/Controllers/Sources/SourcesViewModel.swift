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
        let itemSelected: Action<Source, Void>
        let searchText: BehaviorRelay<String?>
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
    private let searchText = BehaviorRelay<String?>(value: "")
    
    init(reachabilityService: ReachabilityServiceType, sourceServiceType: SourceServiceType) {
        self.reachabilityService = reachabilityService
        self.sourceServiceType = sourceServiceType
        
        let sections = Observable.combineLatest(searchText, sourcesLoadingState).map({
            [unowned self] (searchText, sourcesLoadingState) ->
            [SourcesViewModel.Section] in
            return self.createSections(sourceLoadingState: sourcesLoadingState, searchText: searchText ?? "")
        })
        
        internalOutput = Output(loadingState: sourcesLoadingState, sections: sections.asDriver(onErrorJustReturn: []))
        
        internalInput = Input(sources: createSourcesRequestAction(), itemSelected: itemSelectedAction(), searchText: searchText)
                
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
    
    private func itemSelectedAction() -> Action<Source, Void> {
        return Action<Source, Void> { [unowned self] (item) -> Observable<Void> in
            return Observable.create({ observer in
                self.steps.accept(AppSteps.sourceMain(source: item))
                observer.onCompleted()
                return Disposables.create()
            })
        }
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
    
    private func createSections(sourceLoadingState: SourcesLoadingState, searchText: String) -> [Section] {
        var sections: [Section] = []
        
        switch sourceLoadingState {
        case let .success(sources):
            let sourceItems = createSourceItems(sources: sources, searchText: searchText)
            sections = [.sources(items: sourceItems)]
        default:
            return sections
        }
        return sections
    }
    
    private func createSourceItems(sources: [Source], searchText: String) -> [Item] {
        let filteredSources = sources.filter({$0.name.lowercased().hasPrefix(searchText.lowercased())})
        return filteredSources.map({ item -> Item in
            Item.source(item)
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
