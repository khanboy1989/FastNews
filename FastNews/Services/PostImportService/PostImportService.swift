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
        
    init(postClient: PostClient) {
        self.postClient = postClient
    }
    
    var managedImportService: ManagedImportServiceType {
        return self
    }
    
    var importerId: String {
        return String(describing: self)
    }
    
    func runManagedImport() -> Observable<Void> {
        return runImport().map({ _ in () })
    }
    
    func runImport() -> Observable<[Post]> {
        return postClient
            .posts()
            .map { posts in
                print("posts = \(posts)")
                return posts
            }
    }
}
