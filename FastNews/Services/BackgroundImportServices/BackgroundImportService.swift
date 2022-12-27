//
//  BackgroundImportService.swift
//  FastNews
//
//  Created by Serhan Khan on 27.12.22.
//

import Foundation
import RxSwift

class BackgroundImportService: BackgroundImportServiceType {

    private var importServices = [String: ManagedImportServiceType]()
    private let disposeBag = DisposeBag()
    
    init(foregroundBackgroundService: AppInformationServiceType) {
       scheduleBackgroundImports(foregroundBackgroundService: foregroundBackgroundService)
    }
    
    private func scheduleBackgroundImports(foregroundBackgroundService: AppInformationServiceType) {
        //every hour
        let timer = Observable<Int>.interval(.seconds(60 * 60), scheduler: MainScheduler.instance)
            .map({ _ in () })
        
        //whenever the app becomse active
        let foreground = foregroundBackgroundService.appState
            .filter({ $0 == .active })
            .map({ _ in () })
            .asObservable()

        //throttle to once per hour on app start
        Observable.merge(timer, foreground)
            .throttle(.seconds(60 * 60), scheduler: MainScheduler.instance)
            .flatMap({[unowned self] _ -> Observable<Void> in
                return self.runBackgroundImports()
            })
            .subscribe()
            .disposed(by: disposeBag)
    }
    
    func registerImportService(_ importService: ManagedImportServiceType) {
        importServices[importService.importerId] = importService
    }
    
    func unregisterImportService(_ importService: ManagedImportServiceType) {
        importServices.removeValue(forKey: importService.importerId)
    }
    
    private func runBackgroundImports() -> Observable<Void> {
        let importers = self.importServices.values.map({
            $0.runManagedImport()
                .catchAndReturn(())
        })
        return Observable.zip(importers).map({ _ in () })
    }
}
