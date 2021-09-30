//
//  ColorTheme.swift
//  FastNews
//
//  Created by Serhan Khan on 27/09/2021.
//

import Foundation
import UIKit

enum ColorTheme {
    case appBackground
    case black
    case grey
    
    var color: UIColor {
        switch self {
        case .appBackground:
            return UIColor(named: "cAppBackground")!
        case .black:
            return UIColor(named: "black")!
        case .grey:
            return UIColor(named: "grey")!
        }
    }
}
