//
//  SourceClient.swift
//  FastNews
//
//  Created by Serhan Khan on 29/11/2021.
//

import Moya
import Mapper
import RxSwift
import Moya_ModelMapper

class SourceClient {
    private let configuration: SourceApiConfiguration
    private let provider: MoyaProvider<SourceApi>
    
    init(configuration: SourceApiConfiguration,
         provider: MoyaProvider<SourceApi>) {
        self.configuration = configuration
        self.provider = provider
    }
    func sources(country: String) -> Observable<[Source]> {
        let request = provider.rx.request(.sources(config: self.configuration, country: country))
            .observeOn(ConcurrentDispatchQueueScheduler(qos: .utility))
            .map({response -> [Source] in
                let sources = try response.map(to: [Source].self)
                return sources
            })
            .catchError({ (error) in
                let clientError = ClientError(fromError: error)
                throw clientError
            })
            .observeOn(MainScheduler.asyncInstance)
            .asObservable()
        
        return request
    }
}
