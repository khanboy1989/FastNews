//
//  AppInformationService.swift
//  FastNews
//
//  Created by Serhan Khan on 27.12.22.
//

import Foundation
import RxSwift
import RxCocoa

class AppInformationService: AppInformationServiceType {
    
    private let disposeBag = DisposeBag()
    private let internalAppState = BehaviorRelay<AppState>(value: .unknown)
    
    lazy var appState: Driver<AppState> = {
        return internalAppState.asDriver().distinctUntilChanged()
    }()
    
    let appVersion: String = {
        var appVersion = "v"
        if let version = Bundle.main.infoDictionary?["CFBundleShortVersionString"] as? String, !appVersion.isEmpty {
            appVersion += version
        }
       
        if let build = Bundle.main.infoDictionary?["CFBundleVersion"] as? String, !build.isEmpty {
            appVersion += "(\(build))"
        }
        
        switch Environment.current {
        case .debug:
            appVersion += "-d"
        case .release:
            appVersion += "-p"
        }
        
       print("app version is set to be = \(appVersion)")
       return appVersion
        
    }()
    
    init() {
        let enterBackground = [
            NotificationCenter.default.rx.notification(UIApplication.willResignActiveNotification),
            NotificationCenter.default.rx.notification(UIApplication.didEnterBackgroundNotification),
            NotificationCenter.default.rx.notification(UIApplication.willTerminateNotification)
        ]
        
        NotificationCenter.default.rx.notification(UIApplication.didBecomeActiveNotification)
            .map({ _ in AppState.active})
            .bind(to: internalAppState)
            .disposed(by: disposeBag)
        
        Observable.merge(enterBackground)
            .map{ _ in AppState.background }
            .bind(to: internalAppState)
            .disposed(by: disposeBag)
    }
    
}
