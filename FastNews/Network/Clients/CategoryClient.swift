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
        let request = provider.rx.request(.topHeadLines(config: self.configuration, category: categoryType, lang: lang))
            .observe(on: ConcurrentDispatchQueueScheduler(qos: .utility))
            .map({response -> TopHeadLinesModel in
                let topHeadlines = try response.map(to: TopHeadLinesModel.self)
                return topHeadlines
            })
            .catch({ (error) in
                let clientError = ClientError(fromError: error)
                throw clientError
            })
                .observe(on: MainScheduler.asyncInstance)
            .asObservable()
        
        return request
    }
}
