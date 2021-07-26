//
//  ContactTableViewCell.swift
//  ContactApp
//
//  Created by Mohshin on 26/7/21.
//

import Foundation
import UIKit

class ContactTableViewCell: UITableViewCell {
    
    @IBOutlet weak var avtarImageView: UIImageView!
    @IBOutlet weak var fullNameLabel: UILabel!
    
    func configure(using viewModel: ContactCellViewModel) {
        fullNameLabel.text = viewModel.fullName
    }
}
