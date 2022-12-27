//
//  Bootstrapper.swift
//  FastNews
//
//  Created by Serhan Khan on 27.12.22.
//

import Foundation

final class Bootstrapper {
    static func run(dependencies: Dependencies) {
        initBackgroundImports(dependencies: dependencies)
    }
    
    private static func initBackgroundImports(dependencies: Dependencies) {
        let backgroundImportService = dependencies.resolve(BackgroundImportServiceType.self)
        
//        let configurationImportService = dependencies.resolve(ConfigurationImportServiceType.self)
//        backgroundImportService.registerImportService(configurationImportService.managedImportService)
    }
}
