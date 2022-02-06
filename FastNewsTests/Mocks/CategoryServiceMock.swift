//
//  CategoryServiceMock.swift
//  FastNewsTests
//
//  Created by Serhan Khan on 06/02/2022.
//

import Foundation
import RxSwift
import RxCocoa

@testable import FastNews

class CategoryServiceMock: CategoryServiceType {
    
    func topHeadLines(_ categoryType: CategoryType, _ lang: String) -> Observable<TopHeadLinesModel> {
        return Observable.empty()
    }
}

