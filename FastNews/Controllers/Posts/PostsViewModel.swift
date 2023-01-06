//
//  PostsViewModel.swift
//  FastNews
//
//  Created by Serhan Khan on 06.01.23.
//

import RxFlow
import RxCocoa
import RxSwift
import Action
import Differentiator

class PostsViewModel: ViewModelType, Stepper {
    let steps = PublishRelay<Step>()
    
    struct Input {
        
    }
    struct Output {
        let sections: Driver<[Section]>
    }
    
    var input: Input { return internalInput }
    var output: Output { return internalOutput }
    
    private var internalInput: Input!
    private var internalOutput: Output!
    private let postStorageService: PostStorageServiceType
    
    init(postStorageService: PostStorageServiceType) {
        self.postStorageService = postStorageService
        
        let sections = postStorageService.allPosts()
            .map({ [unowned self] (posts) -> [PostsViewModel.Section] in
            return self.createSections(posts: posts)
        })
        
        internalInput = Input()
        internalOutput = Output(sections: sections.asDriver(onErrorJustReturn: []))
    }
    
    private func createSections(posts: [Post]) -> [Section] {
        var sections: [Section] = []
        let postItems = createPostItems(posts: posts)
        sections = [.posts(items: postItems)]
        return sections
    }
    
    private func createPostItems(posts: [Post]) -> [Item] {
        return posts.map({
            return Item.post($0)
        })
    }
    
    enum Item: IdentifiableType {
        case post(Post)
        
        var identity: String {
            switch self {
            case let .post(post):
                return "post-\(post.id)"
            }
        }
    }
    
    enum Section: SectionModelType {
        case posts(items: [Item])
        
        var identity: Int {
            switch self {
            case .posts:
                return 0
            }
        }
        
        var items: [Item] {
            switch self {
            case let .posts(items: items):
                return items
            }
        }
        
        init(original: PostsViewModel.Section, items: [PostsViewModel.Item]) {
            switch original {
            case .posts:
                self = .posts(items: items)
            }
        }
    }
}
