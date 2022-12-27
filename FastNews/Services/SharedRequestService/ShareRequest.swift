//
//  ShareRequest.swift
//  FastNews
//
//  Created by Serhan Khan on 27.12.22.
//

import Foundation
import RxSwift

class SharedRequest<T> {
    private var runningRequest: Observable<T>?
    private let lock = NSObject()
    
    private let createRequestAction: () -> Observable<T>
    
    init(createRequestAction: @escaping () -> Observable<T>) {
        self.createRequestAction = createRequestAction
    }
    
    func importRequest() -> Observable<T> {
        let request = lock.news.synchronized { () -> Observable<T> in
            if let request = runningRequest {
                return request
            }
            
            //this assumes that the throttle action does not take a significant time
            let request = createRequestAction()
            let sharedRequest = request
                .observe(on: MainScheduler.instance)
                .do(onDispose: {[weak self] in
                    self?.lock.news.synchronized({
                        self?.runningRequest = nil
                    })
                })
                    .share(replay: 1)
                    runningRequest = sharedRequest
                    return sharedRequest
            
        }
        return request
    }
    
}
