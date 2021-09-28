//
//  ColorTheme.swift
//  FastNews
//
//  Created by Serhan Khan on 27/09/2021.
//

import Foundation
import UIKit


enum ColorTheme{
    case appBackground
    
    
    
    var color:UIColor{
        switch self {
        case .appBackground:
            return UIColor(named: "cAppBackground")!
        }
    }
}
