//
//  Alertable.swift
//  FastNews
//
//  Created by Serhan Khan on 06/11/2021.
//

import Foundation
import UIKit

public protocol Alertable {}

public extension Alertable where Self: UIViewController {
    func showAlert(title: String = "", message: String, preferredStyle: UIAlertController.Style = .alert, completion: (() -> Void)? = nil) {
        let alert = UIAlertController(title: title, message: message, preferredStyle: .alert)
        alert.addAction(UIAlertAction(title: Localizable.General.ok.localized, style: UIAlertAction.Style.default, handler: nil))
        self.present(alert, animated: true, completion: completion)
    }
}
