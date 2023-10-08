//
//  PostImportService.swift
//  FastNews
//
//  Created by Serhan Khan on 28.12.22.
//

import Foundation
import RxSwift

class PostImportService: PostImportServiceType, ManagedImportServiceType {
    
    private let postClient: PostClient
    private let disposeBag = DisposeBag()
    private let postStorageService: PostStorageServiceType
    
    init(postClient: PostClient, postStorageService: PostStorageServiceType) {
        self.postClient = postClient
        self.postStorageService = postStorageService
    }
    
    var managedImportService: ManagedImportServiceType {
        return self
    }
    
    var importerId: String {
        return String(describing: self)
    }
    
    func runImport() -> Observable<[Post]> {
        return postClient
            .posts()
            .flatMap { posts in
                self.postStorageService.updateOrCreate(posts: posts)
            }
    }
    
    func runManagedImport() -> Observable<Void> {
        return runImport().map({ _ in () })
    }
    
}
