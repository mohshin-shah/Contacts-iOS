//
//  ContactTableViewCell.swift
//  ContactApp
//
//  Created by Mohshin on 26/7/21.
//

import Foundation
import UIKit
import SDWebImage

class ContactTableViewCell: UITableViewCell {
    
    @IBOutlet weak var avtarImageView: UIImageView!
    @IBOutlet weak var fullNameLabel: UILabel!
    
    func configure(using viewModel: ContactCellViewModel) {
        avtarImageView.sd_setImage(
            with: viewModel.avatarURL,
            placeholderImage: nil,
            options: [],
            context: [.imageThumbnailPixelSize : CGSize(width: 200, height: 200)]
        )
        avtarImageView.sd_imageTransition = .fade(duration: 0.3)
        fullNameLabel.text = viewModel.fullName
    }
}
