//
//  ArticleTableViewCell.swift
//  FastNews
//
//  Created by Serhan Khan on 26/10/2021.
//

import UIKit

class ArticleTableViewCell: UITableViewCell, NibReusable {

    @IBOutlet private weak var titleLabel: UILabel!
    @IBOutlet private weak var sourceImageView: UIImageView!
    @IBOutlet private weak var sourceLabel: UILabel!
    
    var article: CategoriesViewModel.Article? {
        didSet{
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
        sourceImageView.contentMode = .scaleAspectFit
        
        titleLabel.font = UIFont.mediumFont(size: 16)
        titleLabel.textColor = ColorTheme.black.color
        
        sourceLabel.textColor = ColorTheme.grey.color
        sourceLabel.font = UIFont.bookFont(size: 12)
    }
    
    private func updateUI(article: CategoriesViewModel.Article?) {
        
    }

}
