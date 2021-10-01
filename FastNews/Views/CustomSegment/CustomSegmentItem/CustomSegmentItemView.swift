//
//  CustomeSegmentItem.swift
//  FastNews
//
//  Created by Serhan Khan on 30/09/2021.
//

import UIKit

class CustomSegmentItemView: UIView, NibOwnerLoadable {
    var onTap: ( () -> Void)?
    
    @IBOutlet private weak var titleLabel: UILabel!
    @IBOutlet private weak var indicatorView: UIView!
    
    var item: CustomSegmentItem? {
        didSet {
            refresh()
        }
    }
    
    var isSelected: Bool = false {
        didSet {
           refresh()
        }
    }

    init(item: CustomSegmentItem) {
        super.init(frame: .zero)
        self.item = item
        sharedInit()
    }
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        sharedInit()
    }
    
    required init?(coder: NSCoder) {
        super.init(coder: coder)
        sharedInit()
    }
    
    private func sharedInit() {
        indicatorView.layer.cornerRadius = indicatorView.layer.frame.height / 2.0
    }
    
    private func refresh() {
        titleLabel.text = item?.title
        switch isSelected {
        case true:
            titleLabel.font = UIFont.mediumFont(size: 18)
            titleLabel.textColor = ColorTheme.black.color
            indicatorView.isHidden = false
        case false:
            titleLabel.font = UIFont.mediumFont(size: 16)
            titleLabel.textColor = ColorTheme.grey.color
            indicatorView.isHidden = true
        }
    }
    
    @IBAction private func didTap(_ sender: UIButton) {
        onTap?()
    }

}

struct CustomSegmentItem {
    var title: String
}
