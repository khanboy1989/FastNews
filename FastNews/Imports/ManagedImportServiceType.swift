//
//  ManagedImportServiceType.swift
//  FastNews
//
//  Created by Serhan Khan on 27.12.22.
//

import Foundation
import RxSwift

protocol ManagedImportServiceType {
    var importerId: String { get }
    func runManagedImport() -> Observable<Void>
}
