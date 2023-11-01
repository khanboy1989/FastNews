//
//  ReachabilityServiceMock.swift
//  FastNewsTests
//
//  Created by Serhan Khan on 25/01/2022.
//

import RxSwift
import RxCocoa
import Action

@testable import FastNews

class ReachabilityServiceMock: ReachabilityServiceType {
    func didBecomeReachable() -> Observable<Bool> {
        return isAvailable ? Observable.just(true) : Observable.just(false)
    }
    //computed property
    var isAvailable: Bool = true
}
