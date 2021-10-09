//
//  CategoryClient.swift
//  FastNews
//
//  Created by Serhan Khan on 06/10/2021.
//

import Moya
import Mapper
import RxSwift
import Moya_ModelMapper

class CategoryClient {
    private let configuration: CategoryApiConfiguration
    private let provider: MoyaProvider<CategoryApi>
    
    init(configuration: CategoryApiConfiguration, provider: MoyaProvider<CategoryApi>) {
        self.configuration = configuration
        self.provider = provider
    }
    
    func topHeadlines(categoryType: CategoryType, lang: String) -> Observable<TopHeadLinesModel> {
        let request = provider.rx.request(.topHeadLines(config: self.configuration, category: categoryType, lang: lang))
            .observeOn(ConcurrentDispatchQueueScheduler(qos: .utility))
            .map({response -> TopHeadLinesModel in
                let topHeadlines = try response.map(to: TopHeadLinesModel.self)
                print("topHeadlines:\(topHeadlines)")
                return topHeadlines
            })
            .catchError({ (error) in
                print("Error:\(error)")
                throw error
            })
            .observeOn(MainScheduler.asyncInstance)
            .asObservable()

        return request
    }
}
