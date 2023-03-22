//
//  DefaultStyleNavigationController.swift
//  FastNews
//
//  Created by Serhan Khan on 25/11/2021.
//

import Foundation
import UIKit

protocol DefaultStyleNavigationProtocol {
    func configureNavBar()
}

class DefaultStyleNavigationController: UINavigationController, DefaultStyleNavigationProtocol {
    
    override init(rootViewController: UIViewController) {
        super.init(rootViewController: rootViewController)
        configureNavBar()
    }
    
    override init(navigationBarClass: AnyClass?, toolbarClass: AnyClass?) {
        super.init(navigationBarClass: navigationBarClass, toolbarClass: toolbarClass)
        configureNavBar()
    }
    
    override init(nibName nibNameOrNil: String?, bundle nibBundleOrNil: Bundle?) {
        super.init(nibName: nibNameOrNil, bundle: nibBundleOrNil)
        configureNavBar()
    }
    
    required init?(coder aDecoder: NSCoder) {
        super.init(coder: aDecoder)
        configureNavBar()
    }
    
    func configureNavBar() {
        UINavigationBar.appearance().barTintColor = .black
        UINavigationBar.appearance().tintColor = .black
        UINavigationBar.appearance().titleTextAttributes = [NSAttributedString.Key.foregroundColor: UIColor.black]
        UINavigationBar.appearance().isTranslucent = true
        UINavigationBar.appearance().shadowImage = UIImage()
        UINavigationBar.appearance().setBackgroundImage(UIImage(), for: .default)
    }
    
    
}
