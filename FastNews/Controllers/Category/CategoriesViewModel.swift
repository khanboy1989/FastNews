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
    }
    
    var input: Input { return internalInput }
    var outPut: Output { return internalOutput }
    
    private var internalInput: Input!
    private var internalOutput: Output!
    private let categoryService: CategoryServiceType!
    private let reachabilityService: ReachabilityServiceType
    private let categoryTypes = BehaviorRelay<[CustomSegmentItem]>(value: [])
    private let selectedCategoryType = BehaviorRelay<CategoryType>(value: .business)
    private let loadingState = BehaviorRelay<ArticlesLoadingState>(value: .loading)
    private let articleLoadingState = BehaviorRelay<ArticlesLoadingState>(value: .loading)
    private let articleRequest = PublishSubject<Observable<ArticlesLoadingState>>()
    private let disposeBag = DisposeBag()
    
    init(reachabilityService: ReachabilityServiceType, categoryService: CategoryServiceType) {
        self.reachabilityService = reachabilityService
        self.categoryService = categoryService
        
        internalOutput = Output(categoryTypes: categoryTypes.asDriver(), selectedCategoryType: selectedCategoryType.asDriver(),
                                loadingState: loadingState)
        internalInput = Input(selectedCategoryType: createSelectCategoryAction())
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
            .catchErrorJustReturn(ArticlesLoadingState.error(.unknown))
    }
    
    struct Article {
        let title: String?
        let description: String?
        let url: String?
        let imageUrl: String?
        let source: String?
        let publishedAt: String?
        
        var image: URL? {
            guard let urlToImage = imageUrl else {
                return nil
            }
            return URL(string: urlToImage)
        }
        
        var date: String? {
            guard let publishedAt = publishedAt else {
                return nil
            }
            
            let dateFormatter = DateFormatter()
            dateFormatter.dateFormat = "yyyy-MM-dd'T'HH:mm:ss"
            guard let formattedDate = dateFormatter.date(from: publishedAt) else {
                return nil
            }
            
            let converDateFormatter = DateFormatter()
            converDateFormatter.dateFormat = "MMM dd yyy"
            return converDateFormatter.string(from: formattedDate)
        }
    }
}

extension CategoriesViewModel.Article {
    
    init(articleModel: ArticleModel) {
        self.title = articleModel.title
        self.description = articleModel.description
        self.imageUrl = articleModel.urlToImage
        self.url = articleModel.url
        self.publishedAt = articleModel.publishedAt
        self.source = articleModel.source?.name
    }
}
