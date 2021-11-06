//
//  CategoriesViewModel.swift
//  FastNews
//
//  Created by Serhan Khan on 29/09/2021.
//

import RxFlow
import RxCocoa
import RxSwift
import Action
import RxDataSources

class CategoriesViewModel: ViewModelType, Stepper {
    typealias ArticlesLoadingState = LoadingState<[Article]>
    
    let steps = PublishRelay<Step>()
    let defaultLanguage: String = "en"
    
    struct Input {
        let selectedCategoryType: Action<Int, Void>
    }
    
    struct Output {
        let categoryTypes: Driver<[CustomSegmentItem]>
        let selectedCategoryType: Driver<CategoryType>
        let loadingState: BehaviorRelay<ArticlesLoadingState>
        let sections: Driver<[Section]>
    }
    
    var input: Input { return internalInput }
    var output: Output { return internalOutput }
    
    private var internalInput: Input!
    private var internalOutput: Output!
    private let categoryService: CategoryServiceType!
    private let reachabilityService: ReachabilityServiceType
    private let categoryTypes = BehaviorRelay<[CustomSegmentItem]>(value: [])
    private let selectedCategoryType = BehaviorRelay<CategoryType>(value: .business)
    private let articleLoadingState = BehaviorRelay<ArticlesLoadingState>(value: .loading)
    private let articleRequest = PublishSubject<Observable<ArticlesLoadingState>>()
    private let disposeBag = DisposeBag()
    
    init(reachabilityService: ReachabilityServiceType, categoryService: CategoryServiceType) {
        self.reachabilityService = reachabilityService
        self.categoryService = categoryService
        
        categoryTypes.accept(createCategoryTypes(selectedItem: selectedCategoryType.value))
        
        articleRequest.do(onNext: { [weak self] _ in
            self?.articleLoadingState.accept(.loading)
        })
          .switchLatest()
          .bind(to: articleLoadingState)
          .disposed(by: disposeBag)
        
        selectedCategoryType
            .asDriver()
            .drive(onNext: { [weak self] categorType in
                guard let self = self else { return }
                let articles = self.createTopHeadlinesRequest(categoryType: categorType)
                self.articleRequest.onNext(articles)
            })
            .disposed(by: disposeBag)
            
            internalInput = Input(selectedCategoryType: createSelectCategoryAction())
            
            internalOutput = Output(categoryTypes: categoryTypes.asDriver(), selectedCategoryType: selectedCategoryType.asDriver(),
                                    loadingState: articleLoadingState,
                                    sections: createSections(loadingState: articleLoadingState.asObservable()).asDriver(onErrorJustReturn: []))
            
    }
    
    private func createCategoryTypes(selectedItem: CategoryType) -> [CustomSegmentItem] {
        return CategoryType.allCases.map({ item -> CustomSegmentItem in
            if item == selectedItem {
                self.selectedCategoryType.accept(selectedItem)
                return CustomSegmentItem(title: item.title, isSelected: true)
            } else {
                return CustomSegmentItem(title: item.title, isSelected: false)
            }
        })
    }
    
    private func createSelectCategoryAction() -> Action<Int, Void> {
        return Action<Int, Void>(workFactory: {[weak self] index in
            return Observable.create { observer in
                if let strongSelf = self, let selectedItem = CategoryType.allCases.first(where: { $0.index == index }) {
                    strongSelf.categoryTypes.accept(strongSelf.createCategoryTypes(selectedItem: selectedItem))
                }
                observer.onCompleted()
                return Disposables.create()
            }
        })
    }
    
    private func createSections(loadingState: Observable<ArticlesLoadingState>) -> Observable<[Section]> {
        return loadingState
            .debounce(.milliseconds(100), scheduler: MainScheduler.instance)
            .map({ state -> [Section] in
            var sections = [Section]()
            switch state {
            case let .success(articles):
                let items = articles.map({
                    Item.headline($0)
                })
                sections.append(.topHeadLines(items: items))
                return sections
            default:
                return []
            }
        })
    }
    
    private func createTopHeadlinesRequest(categoryType: CategoryType) -> Observable<ArticlesLoadingState> {
        return self.categoryService
            .topHeadLines(categoryType, self.defaultLanguage)
            .asObservable()
            .map({ articles in
            let items = articles.articles.map({
                return Article(articleModel: $0)
            })
                return ArticlesLoadingState.success(items)
            })
            .catchError({ [unowned self] error -> Observable<ArticlesLoadingState> in
                let result: ArticlesLoadingState
                if self.reachabilityService.isAvailable == false {
                    result = .error(.noInternet)
                } else {
                    result = .error(.custom(error.localizedDescription))
                }
                return Observable.just(result)
            })
    }
    
    enum Item: IdentifiableType {
        case headline(Article)
        
        var identity: String {
            switch self {
            case .headline(let article):
                return "headline-\(article.title!)"
            }
        }
    }
    
    enum Section: SectionModelType {
        case topHeadLines(items: [Item])
        
        var identity: Int {
            switch self {
            case .topHeadLines:
                return 0
            }
        }
        
        var items: [Item] {
            switch self {
            case let .topHeadLines(items: items):
                return items
            }
        }
        
        init(original: CategoriesViewModel.Section, items: [Item]) {
            switch original {
            case .topHeadLines:
                self = .topHeadLines(items: items)
            }
        }
    }
    
}
