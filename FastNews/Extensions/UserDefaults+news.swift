//
//  UserDefaults+news.swift
//  FastNews
//
//  Created by Serhan Khan on 06.01.23.
//

import Foundation

extension News where Base == UserDefaults {
    static func set(value: Any, forKey key: String) {
        UserDefaults.standard.set(value, forKey: key)
        UserDefaults.standard.synchronize()
    }
    
    static func value(forKey key: String) -> Any? {
        return UserDefaults.standard.object(forKey: key)
    }
    
    static func has(valueForKey key: String) -> Bool {
        return UserDefaults.standard.object(forKey: key) != nil
    }
    
    static func remove(dataForkey key: String) {
        UserDefaults.standard.removeObject(forKey: key)
    }
    
    static func setValueTemporarily(value: Any, forKey: String, durationIn seconds: Double = 20) {
        UserDefaults.standard.set(value, forKey: forKey)
        UserDefaults.standard.synchronize()
        DispatchQueue.main.asyncAfter(deadline: .now() + seconds) {
            UserDefaults.standard.removeObject(forKey: forKey)
        }
    }
}
