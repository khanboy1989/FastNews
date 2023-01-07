//
//  Reachability.swift
//  FastNews
//
//  Created by Serhan Khan on 22/09/2021.
//

import Foundation
import RxSwift
import RxCocoa
import Alamofire

protocol ReachabilityServiceType {
    func didBecomeReachable()-> Observable<Bool>
    var isAvailable: Bool { get }
}

final class ReachabilityService: ReachabilityServiceType {
    
    private let reachability = NetworkReachabilityManager()
    private let _didBecomeReachable = PublishSubject<Bool>()
    init() {
        if let reachability = reachability {
            reachability.startListening(onUpdatePerforming: { status in
                #if DEBUG
                print("ReachabilityService interent:\(status)")
                #endif
                switch status {
                case .notReachable:
                    self._didBecomeReachable.onNext(false)
                case .reachable:
                    self._didBecomeReachable.onNext(true)
                case .unknown:
                    self._didBecomeReachable.onNext(false)
                }
            })
        }
    }
    
    deinit {
        #if DEBUG
        print("\(type(of: self)): \(#function)")
        #endif
        if let reachability = reachability {
            reachability.stopListening()
        }
    }
    
    func didBecomeReachable() -> Observable<Bool> {
        return _didBecomeReachable.asObservable()
    }
    
    var isAvailable: Bool {
        let hasInternet = reachability?.isReachable ?? false
        return hasInternet
    }
}
