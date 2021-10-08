//
//  CategoryService.swift
//  FastNews
//
//  Created by Serhan Khan on 08/10/2021.
//

import RxSwift



class CategoryService: CategoryServiceType {
    
    private let categoryClient: CategoryClient
   
   
    init(categoryClient: CategoryClient) {
        self.categoryClient = categoryClient
    }
    
    func topHeadLines(_ categoryType: CategoryType, _ lang: String) -> Observable<TopHeadLinesModel> {
        return categoryClient.topHeadlines(categoryType: categoryType, lang: lang)
    }
    
    
}

