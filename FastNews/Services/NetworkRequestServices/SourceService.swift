//
//  SourceService.swift
//  FastNews
//
//  Created by Serhan Khan on 01/12/2021.
//

import Foundation
import RxSwift

class SourceService: SourceServiceType {
    
    private let sourceClient: SourceClient
   
    init(sourceClient: SourceClient) {
        self.sourceClient = sourceClient
    }
    
    func sources(_ country: String) -> Observable<[Source]> {
        return sourceClient.sources(country: country)
    }
}
