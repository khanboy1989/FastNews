//
//  Article.swift
//  FastNews
//
//  Created by Serhan Khan on 01/11/2021.
//

import Foundation


struct Article {
    let title: String?
    let description: String?
    let url: String?
    let imageUrl: String?
    let source: String?
    let publishedAt: String?
    
    var image: URL? {
        guard let urlToImage = imageUrl else {
            return nil
        }
        return URL(string: urlToImage)
    }
    
    var date: String? {
        guard let publishedAt = publishedAt else {
            return nil
        }
        
        //2021-11-06T14:01:07Z
        let dateFormatter = DateFormatter()
        dateFormatter.dateFormat = "yyyy'-'MM'-'dd'T'HH':'mm':'ssZZZ"
        guard let formattedDate = dateFormatter.date(from: publishedAt) else {
            return nil
        }
        
        let converDateFormatter = DateFormatter()
        converDateFormatter.dateFormat = "MMM dd yyy"
        return converDateFormatter.string(from: formattedDate)
    }
}

extension Article {
    
    init(articleModel: ArticleModel) {
        self.title = articleModel.title
        self.description = articleModel.description
        self.imageUrl = articleModel.urlToImage
        self.url = articleModel.url
        self.publishedAt = articleModel.publishedAt
        self.source = articleModel.source?.name
    }
}

extension Article: Hashable {
    
    static func == (lhs: Article, rhs: Article) -> Bool {
        return lhs.hashValue == rhs.hashValue
    }
    
    func hash(into hasher: inout Hasher) {
        hasher.combine(title)
        hasher.combine(description)
        hasher.combine(imageUrl)
        hasher.combine(url)
        hasher.combine(publishedAt)
        hasher.combine(source)
    }
}
