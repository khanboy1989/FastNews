//
//  ViewController.swift
//  FastNews
//
//  Created by Serhan Khan on 21/09/2021.
//

import UIKit
import RxSwift

class CategoriesViewController: UIViewController, StoryboardBased, ViewModelBased {
    
    var viewModel: CategoriesViewModel!
    @IBOutlet private weak var customSegmentsView: CustomSegmentsView!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        var customSegmentItems = [CustomSegmentItem]()
        
        let allCases = CategoryType.allCases
        
        for item in allCases {
            if item == .business {
                customSegmentItems.append(CustomSegmentItem(title: item.title, isSelected: true))
            } else {
                customSegmentItems.append(CustomSegmentItem(title: item.title, isSelected: false))
            }
        }
        customSegmentsView.setItems(items: customSegmentItems)
    }
}
