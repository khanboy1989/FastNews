//
//  Strings+news.swift
//  FastNews
//
//  Created by Serhan Khan on 30/09/2021.
//

import Foundation


extension String: NewsCompatible { }

extension News where Base == String {
    var localized: String {
        return NSLocalizedString(self.base, comment: "")
    }

}
