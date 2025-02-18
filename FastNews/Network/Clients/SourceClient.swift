//
//  SourceClient.swift
//  FastNews
//
//  Created by Serhan Khan on 29/11/2021.
//

import Moya
import Mapper
import RxSwift
import Foundation
import RxMoya

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
            .observe(on: ConcurrentDispatchQueueScheduler(qos: .utility))
            .map({response -> [Source] in
                let sources = try response.map(to: [Source].self, keyPath: "sources")
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
    
    static func stringify(json: Any, prettyPrinted: Bool = false) -> String {
        var options: JSONSerialization.WritingOptions = []
        if prettyPrinted {
          options = JSONSerialization.WritingOptions.prettyPrinted
        }

        do {
          let data = try JSONSerialization.data(withJSONObject: json, options: options)
          if let string = String(data: data, encoding: String.Encoding.utf8) {
            return string
          }
        } catch {
          print("stringify error = \(error)")
        }

        return ""
    }
}
