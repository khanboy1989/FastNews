//
//  AppServiceType.swift
//  FastNews
//
//  Created by Serhan Khan on 27.12.22.
//

import Foundation
import RxSwift
import RxCocoa

enum AppState {
    case unknown
    case active
    case background
}

protocol AppInformationServiceType {
    var appState: Driver<AppState> { get }
    var appVersion: String { get }
}
