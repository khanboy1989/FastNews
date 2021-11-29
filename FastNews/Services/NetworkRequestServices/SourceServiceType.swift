//
//  SourceServiceType.swift
//  FastNews
//
//  Created by Serhan Khan on 29/11/2021.
//

import Foundation
import RxSwift


protocol SourceServiceType {
    func sources(_ country: String) -> Observable<[Source]>
}
