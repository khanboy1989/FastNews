//
//  SourceHeaderView.swift
//  FastNews
//
//  Created by Serhan Khan on 09/01/2022.
//

import Foundation
import UIKit

class SourceHeaderView: UIView, NibOwnerLoadable {
    
    @IBOutlet private weak var searchBar: UISearchBar!

    
    override init(frame: CGRect) {
        super.init(frame: frame)
        loadNibContent()
    }
    
    
    
    required init?(coder: NSCoder) {
        super.init(coder: coder)
        loadNibContent()
    }
}
