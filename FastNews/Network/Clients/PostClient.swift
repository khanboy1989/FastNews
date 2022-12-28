//
//  PostClient.swift
//  FastNews
//
//  Created by Serhan Khan on 28.12.22.
//

import Moya
import Mapper
import RxSwift

class PostClient {
    
    private let configuration: PostsJsonPlaceHolderApiConfiguration
    private let provider: MoyaProvider<PostApi>
    
    init(configuration: PostsJsonPlaceHolderApiConfiguration,
         provider: MoyaProvider<PostApi>) {
        self.configuration = configuration
        self.provider = provider
    }
    
    func posts() -> Observable<[Post]> {
        let request = provider.rx.request(.posts(config: self.configuration))
            .observe(on: ConcurrentDispatchQueueScheduler(qos: .utility))
            .map({response -> [Post] in
                let sources = try response.map(to: [Post].self)
                return sources
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
