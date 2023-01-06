//
//  PostStorageServiceType.swift
//  FastNews
//
//  Created by Serhan Khan on 29.12.22.
//

import Foundation
import RxSwift

protocol PostStorageServiceType {
    func updateOrCreate(posts: [Post]) -> Observable<[Post]>
    func allPosts() -> Observable<[Post]>
}
