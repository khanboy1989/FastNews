//
//  ViewModelType.swift
//  FastNews
//
//  Created by Serhan Khan on 23/09/2021.
//

import Foundation

protocol ViewModelType {
    associatedtype Input
    associatedtype Output
    
    var input: Input { get }
    var output: Output { get }
}
