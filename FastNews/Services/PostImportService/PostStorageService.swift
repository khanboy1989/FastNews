//
//  PostStorageService.swift
//  FastNews
//
//  Created by Serhan Khan on 06.01.23.
//

import Foundation
import RxSwift
import RxCocoa

class PostStorageService: PostStorageServiceType {
    
    private static let postsOldKeys = ["com.serhankhan.FastNews.data"]
    
    private static let postsDataKey = "com.serhankhan.FastNews.data.v1"
    
    private let disposeBag = DisposeBag()
    private let posts: BehaviorRelay<[Post]>
    
    init() {
        for oldKey in PostStorageService.postsOldKeys {
            if UserDefaults.news.has(valueForKey: oldKey) {
                UserDefaults.news.remove(dataForkey: oldKey)
            }
        }

        // initialize the cache
        // this has to work, since we provide the data with the bundle
        if let data = UserDefaults.news.value(forKey: PostStorageService.postsDataKey) as? Data {
            let value = NSKeyedUnarchiver.news.decodeDecodable([Post].self, data: data)!
            posts = BehaviorRelay<[Post]>(value: value)
        } else {
            posts = BehaviorRelay<[Post]>(value: [])
        }
        

        // configuration storage
        posts.asObservable()
            .skip(1)
            .subscribe(onNext: {
                do {
                    let data = try NSKeyedArchiver.news.encodeEncodable($0)
                    UserDefaults.news.set(value: data, forKey: PostStorageService.postsDataKey)
                } catch {
                    #if DEBUG
                    print(error)
                    #endif
                }
            })
            .disposed(by: disposeBag)
        
    }
    
    func updateOrCreate(posts: [Post]) -> Observable<[Post]> {
        return Observable
            .create({ [weak self] observer in
                self?.posts.accept(posts)
                observer.onNext(posts)
                observer.onCompleted()
                return Disposables.create()
            })
            .observe(on: MainScheduler.instance)
    }
    
    func allPosts() -> Observable<[Post]> {
        return posts.asObservable()
    }
}
