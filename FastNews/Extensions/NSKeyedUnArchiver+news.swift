//
//  NSKeyedUnArchiver+news.swift
//  FastNews
//
//  Created by Serhan Khan on 06.01.23.
//

import Foundation

extension News where Base: NSKeyedUnarchiver {
    static func decodeDecodable<T>(_ type: T.Type, data: Data) -> T? where T: Decodable {
        let unarchiver = NSKeyedUnarchiver(forReadingWith: data)
        let value = unarchiver.decodeDecodable(type, forKey: NSKeyedArchiveRootObjectKey)
        return value
    }
}
