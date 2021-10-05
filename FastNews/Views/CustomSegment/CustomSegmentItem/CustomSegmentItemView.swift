//
//  CustomeSegmentItem.swift
//  FastNews
//
//  Created by Serhan Khan on 30/09/2021.
//

import UIKit

class CustomSegmentItemView: UIView, NibOwnerLoadable {
    
    @IBOutlet private weak var titleLabel: UILabel!
    @IBOutlet private weak var indicatorView: UIView!
    
    var onTap: ( ( CustomSegmentItem?, Int? ) -> Void)?
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
    
    var index: Int?
    
    init(item: CustomSegmentItem, index: Int) {
        super.init(frame: .zero)
        self.loadNibContent()
        self.item = item
        self.index = index
        sharedInit()
    }
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        self.loadNibContent()
        sharedInit()
    }
    
    required init?(coder: NSCoder) {
        super.init(coder: coder)
        self.loadNibContent()
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
            setView(view: indicatorView, hidden: false)
        case false:
            titleLabel.font = UIFont.mediumFont(size: 16)
            titleLabel.textColor = ColorTheme.grey.color
            setView(view: indicatorView, hidden: true)
        }
    }
    
    @IBAction private func didTap(_ sender: UIButton) {
        onTap?(item, index)
    }
    
    private func setView(view: UIView, hidden: Bool) {
        UIView.transition(with: view, duration: 0.5, options: .transitionCrossDissolve, animations: {
            view.isHidden = hidden
        })
    }
}

struct CustomSegmentItem {
    var title: String
    var isSelected: Bool
}
