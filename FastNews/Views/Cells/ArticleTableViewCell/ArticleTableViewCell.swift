//
//  ArticleTableViewCell.swift
//  FastNews
//
//  Created by Serhan Khan on 26/10/2021.
//

import UIKit
import Kingfisher

class ArticleTableViewCell: UITableViewCell, NibReusable {

    @IBOutlet private weak var titleLabel: UILabel!
    @IBOutlet private weak var sourceImageView: UIImageView!
    @IBOutlet private weak var sourceLabel: UILabel!
    @IBOutlet private weak var dateLabel: UILabel!
    
    var article: Article? {
        didSet {
            updateUI(article: article)
        }
    }
    
    override func awakeFromNib() {
        super.awakeFromNib()
        commonSetup()
    }
    
    func commonSetup() {
        sourceImageView.layer.cornerRadius = 10.0
        sourceImageView.clipsToBounds = true
        sourceImageView.contentMode = .scaleAspectFill
        
        titleLabel.font = UIFont.mediumFont(size: 16)
        titleLabel.textColor = ColorTheme.black.color
        
        sourceLabel.textColor = ColorTheme.grey.color
        sourceLabel.font = UIFont.bookFont(size: 12)
        sourceLabel.textAlignment = .left
        
        dateLabel.textAlignment = .right
        dateLabel.font = UIFont.bookFont(size: 12)
        dateLabel.textColor = ColorTheme.grey.color
    }
    
    private func updateUI(article: Article?) {
        titleLabel.text = article?.title
        sourceLabel.text = article?.source
        dateLabel.text = article?.date
        if let url = article?.imageUrl {
            sourceImageView.kf.setImage(with: URL(string: url))
        }
    }

}
