//
//  Reusable.swift
//  FastNews
//
//  Created by Serhan Khan on 21/09/2021.
//

import UIKit

// MARK: Protocol Definition

/// Make your `UITableViewCell` and `UICollectionViewCell` sublclasses
/// conform to this protocol when they are *not* NIB-b ased but only code-based
/// to be able to dequeue them in a type-safe manner
public protocol Reusable: AnyObject {
    static var reuseIdentifier: String { get }
}

/// Make your `UITableViewCell` and `UICollectionViewCell` subclass
/// conform to this typealias when they *are* NIB-based
public typealias NibReusable = Reusable & NibLoadable

// MARK: - Default Implementation

public extension Reusable {
    /// By default, use the name of the class as String for its reuseIdentifier
    static var reuseIdentifier: String {
        return String(describing: self)
    }
}
