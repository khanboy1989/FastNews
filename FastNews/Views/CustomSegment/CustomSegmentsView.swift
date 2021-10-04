//
//  CustomSegment.swift
//  FastNews
//
//  Created by Serhan Khan on 30/09/2021.
//

import UIKit

class CustomSegmentsView: UIView, NibOwnerLoadable {
    
    @IBOutlet private weak var scrollView: UIScrollView!
    @IBOutlet private weak var stackView: UIStackView!
    
    private var itemViews: [CustomSegmentItemView] = []
    
    var items = [CustomSegmentItem]() {
        didSet {
            refreshSubviews()
        }
    }
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        self.loadNibContent()
        self.shareInit()
    }
    
    required init?(coder: NSCoder) {
        super.init(coder: coder)
        self.loadNibContent()
        self.shareInit()
    }
    
    private func shareInit() {
        scrollView.bounces = false
        scrollView.alwaysBounceVertical = false 
        scrollView.showsVerticalScrollIndicator = false
        scrollView.showsHorizontalScrollIndicator = false
    }
    
    private func refreshSubviews() {
        for view in itemViews {
            view.removeFromSuperview()
            stackView.removeArrangedSubview(view)
        }
        itemViews = []
        
        for (_, item) in items.enumerated() {
            let subview = CustomSegmentItemView(item: item)
            subview.isSelected = item.isSelected
            stackView.addArrangedSubview(subview)
            subview.onTap = {[weak self] customSegmentItem in
            //guard let self = self else {return}
                
            }
            itemViews.append(subview)
        }
        refresh()
    }
    
    func setItems(items: [CustomSegmentItem]) {
        self.items = items
    }
    
    private func refresh() {
    }
    
}
