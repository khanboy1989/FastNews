//
//  SourceTableViewCell.swift
//  FastNews
//
//  Created by Serhan Khan on 05/12/2021.
//

import UIKit

class SourceTableViewCell: UITableViewCell, NibReusable {

    @IBOutlet private weak var titleLabel: UILabel!
    @IBOutlet private weak var descriptionLabel: UILabel!
    @IBOutlet private weak var seperatorView: UIView!
    
    var source: Source? {
        didSet {
            updateUI(source: source)
        }
    }
    
    override func awakeFromNib() {
        super.awakeFromNib()
        commonSetup()
    }

    private func commonSetup() {
        titleLabel.font = UIFont.mediumFont(size: 16)
        titleLabel.textColor = ColorTheme.black.color
        titleLabel.textAlignment = .left
        
        descriptionLabel.font = UIFont.bookFont(size: 12)
        descriptionLabel.textColor = ColorTheme.grey.color
        descriptionLabel.numberOfLines = 0
        descriptionLabel.textAlignment = .left
        
        seperatorView.backgroundColor = ColorTheme.seperator.color
    }
    
    private func updateUI(source: Source?) {
        titleLabel.text = source?.name
        descriptionLabel.text = source?.description
    }
    
}
