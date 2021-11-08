//
//  Asset.swift
//  FastNews
//
//  Created by Serhan Khan on 06/11/2021.
//

import Foundation
import UIKit

enum Asset {
    enum Image: String {
        
        case homeIcon
        case homeIconSelected
        case sourcesIcon
        case sourcesIconSelected
        
        var image: UIImage? {
            return UIImage(named: self.rawValue)
        }
    }
    
}

extension Asset.Image {
    
    var templateImage: UIImage? {
        return UIImage(named: self.rawValue)?.withRenderingMode(.alwaysTemplate)
    }
    var originalImage: UIImage? {
        return UIImage(named: self.rawValue)?.withRenderingMode(.alwaysOriginal)
    }
}
