//
//  UIView+Extensions.swift
//  FastNews
//
//  Created by Serhan Khan on 30/09/2021.
//
import UIKit

extension UIView {
  
    func setGradientBackground(colorLeft: UIColor, colorRight: UIColor) {
        let gradientLayer = CAGradientLayer()
        gradientLayer.colors = [colorLeft.cgColor, colorRight.cgColor]
        gradientLayer.startPoint = CGPoint(x: 0.0, y: 0.5)
        gradientLayer.endPoint = CGPoint(x: 1.0, y: 0.5)
        gradientLayer.frame = bounds
        layer.insertSublayer(gradientLayer, at: 0)
    }
}
