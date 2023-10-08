//
//  PostItemTableViewCell.swift
//  FastNews
//
//  Created by Serhan Khan on 19.03.23.
//

import UIKit

class PostItemTableViewCell: UITableViewCell, NibReusable {

    @IBOutlet private weak var titleLabel: UILabel!
    @IBOutlet private weak var descriptionLabel: UILabel!
    @IBOutlet private weak var seperatorView: UIView!
    
    var post: Post? {
        didSet {
            updateUI(post: post)
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
    
    private func updateUI(post: Post?) {
        titleLabel.text = post?.title
        descriptionLabel.text = post?.body
    }
    
}
