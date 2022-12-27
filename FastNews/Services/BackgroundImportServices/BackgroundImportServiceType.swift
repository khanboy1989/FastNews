//
//  BackgroundImportServiceType.swift
//  FastNews
//
//  Created by Serhan Khan on 27.12.22.
//

import Foundation
import RxSwift

protocol BackgroundImportServiceType {
    func registerImportService(_ importService: ManagedImportServiceType)
    func unregisterImportService(_ importService: ManagedImportServiceType)
}
