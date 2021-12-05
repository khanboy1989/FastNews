//
//  SourceTableViewCell.swift
//  FastNews
//
//  Created by Serhan Khan on 05/12/2021.
//

import UIKit

class SourceTableViewCell: UITableViewCell, NibReusable {

    @IBOutlet private weak var titleLabel: UILabel!
    
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
        titleLabel.font = UIFont.bookFont(size: 21)
    }
    
    private func updateUI(source: Source?) {
        titleLabel.text = source?.name
    }
    
}
