//
//  NSKeyedArchiver.swift
//  FastNews
//
//  Created by Serhan Khan on 06.01.23.
//

import Foundation

extension News where Base: NSKeyedArchiver {
    static func encodeEncodable<T>(_ value: T) throws -> Data where T: Encodable {
        let data = NSMutableData()
        let archiver = NSKeyedArchiver(forWritingWith: data)
        try archiver.encodeEncodable(value, forKey: NSKeyedArchiveRootObjectKey)
        archiver.finishEncoding()
        
        return data as Data
    }
}
