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
    case airBnbCerealLight = "AirbnbCerealLight"
    case airBnbCerealExtraBold = "AirbnbCerealExtraBold"
    case airBnbCerealBook = "AirbnbCerealBook"
    case airBnbCerealBold = "AirbnbCerealBold"
    case airBnbCerealBlack = "AirbnbCerealBlack"
    
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
    
    static func lightFont(size: CGFloat) -> UIFont {
        return Font.airBnbCerealLight.size(size)
    }
    
    static func extraBoldFont(size: CGFloat) -> UIFont {
        return Font.airBnbCerealExtraBold.size(size)
    }
    
    static func bookFont(size: CGFloat) -> UIFont {
        return Font.airBnbCerealBook.size(size)
    }
    
    static func boldFont(size: CGFloat) -> UIFont {
        return Font.airBnbCerealBold.size(size)
    }
    
    static func blackFont(size: CGFloat) -> UIFont {
        return Font.airBnbCerealBlack.size(size)
    }
}
