//
//  PostImportServiceType.swift
//  FastNews
//
//  Created by Serhan Khan on 28.12.22.
//

import Foundation
import RxSwift

protocol PostImportServiceType {
    var managedImportService: ManagedImportServiceType { get }
    func runImport() -> Observable<[Post]>
}
