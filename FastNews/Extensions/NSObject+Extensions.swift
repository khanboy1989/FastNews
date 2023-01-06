//
//  NSObject+Extensions.swift
//  FastNews
//
//  Created by Serhan Khan on 27.12.22.
//

import Foundation

extension NSObject: NewsCompatible { }

extension News where Base: NSObject {
    func synchronized<T>(_ body: () -> T) -> T {
        objc_sync_enter(self.base)
        defer { objc_sync_exit(self.base) }
        return body()
    }
}
