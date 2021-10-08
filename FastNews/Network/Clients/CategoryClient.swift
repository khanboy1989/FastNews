//
//  CategoryClient.swift
//  FastNews
//
//  Created by Serhan Khan on 06/10/2021.
//


import Moya
import Mapper
import RxSwift

class CategoryClient {
    private let configuration: CategoryApiConfiguration
    private let provider: MoyaProvider<CategoryApi>
    
    init(configuration: CategoryApiConfiguration, provider: MoyaProvider<CategoryApi>) {
        self.configuration = configuration
        self.provider = provider
    }
    
    func topHeadlines(categoryType: CategoryType, lang: String) -> Observable<TopHeadLinesModel> {
        return Observable<TopHeadLinesModel>.create{ observer in
            
            observer.onCompleted()
            
            return Disposables.create()
        }
        
    }
}
