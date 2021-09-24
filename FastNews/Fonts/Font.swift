//
//  Font.swift
//  FastNews
//
//  Created by Serhan Khan on 24/09/2021.
//

import Foundation
import UIKit

enum Font: String {
    case airBnbCerealMedium = "AirbnbCerealMedium"
    
    var name: String {
        return self.rawValue
    }

    func size(_ size: CGFloat) -> UIFont {
        return UIFont(name: name, size: size) ?? UIFont.systemFont(ofSize: size)
    }
}

extension UIFont {
    static func mediumFont(size: CGFloat) -> UIFont {
        return Font.airBnbCerealMedium.size(size)
    }
}
