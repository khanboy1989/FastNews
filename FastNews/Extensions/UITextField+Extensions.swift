//
//  UITextField+Extensions.swift
//  FastNews
//
//  Created by Serhan Khan on 19.03.23.
//

import UIKit


extension UITextField{
    var clearButton : UIButton? {
        return self.value(forKey: "_clearButton") as? UIButton
    }
    
    var clearButtonTintColor: UIColor? {
           get {
               return clearButton?.tintColor
           }
           set {
             var image = clearButton?.imageView?.image
                
            if image == nil{
                image = UIImage(named: "clear_field")//this is custom image
            }
        
                image =  image?.withRenderingMode(.alwaysTemplate)
               clearButton?.setImage(image, for: .normal)
               clearButton?.tintColor = newValue
         
           }
       }
}
