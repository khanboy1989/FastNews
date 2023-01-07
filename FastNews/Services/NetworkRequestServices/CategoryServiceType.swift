//
//  CategoryServiceType.swift
//  FastNews
//
//  Created by Serhan Khan on 08/10/2021.
//

import Foundation
import RxSwift

protocol CategoryServiceType {
    func topHeadLines(_ categoryType: CategoryType, _ lang: String) -> Observable<TopHeadLinesModel>
}
