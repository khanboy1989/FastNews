//
//  AppStep.swift
//  FastNews
//
//  Created by Serhan Khan on 23/09/2021.
//

import Foundation
import RxFlow

enum AppSteps: Step {
    case initial
    case main
    case categories
    case sources
    case posts 
    case articleDetail(article: Article)
    case sourceMain(source: Source)
    case postDetail(post: Post)
    case didFinishPostDetail
    case secondPostDetail(post: Post)
}
