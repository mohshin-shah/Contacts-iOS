//
//  PreviewContactViewController.swift
//  ContactApp
//
//  Created by Mohshin on 27/7/21.
//

import UIKit

class PreviewContactViewController: UITableViewController {
    
    @IBOutlet weak var avatarImageView: UIImageView!
    @IBOutlet weak var fullNameLabel: UILabel!
    
    @IBOutlet weak var mobileNumberLabel: UILabel!
    @IBOutlet weak var emailIDLabel: UILabel!
    @IBOutlet weak var favouriteButton: UIButton!

    @IBOutlet weak var headerViewContainer: UIView!
    
    var viewModel: PreviewContactViewModel!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        assert(viewModel != nil)
        viewModel.delegate = self
        setUpViews()
        reloadData()
    }
    
    override func viewDidDisappear(_ animated: Bool) {
        super.viewDidDisappear(animated)
        viewModel.onViewDidDisappear()
    }
    
    private func setUpViews() {
        navigationController?.navigationBar.shadowImage = UIImage()
        navigationItem.rightBarButtonItem = editButtonItem
        tableView.tableFooterView = UIView()

        let gradientLayer = CAGradientLayer()
        gradientLayer.colors = [UIColor.white.cgColor, UIColor.primary.withAlphaComponent(0.4).cgColor]
        gradientLayer.frame = headerViewContainer.bounds
        headerViewContainer.layer.insertSublayer(gradientLayer, at: 0)
    }
    
    private func reloadData() {
        avatarImageView.sd_setImage(with: viewModel.avatarURL)
        fullNameLabel.text = viewModel.fullName
        mobileNumberLabel.text = viewModel.mobileNumber
        emailIDLabel.text = viewModel.emailID
        favouriteButton.isSelected = viewModel.isFavourite
        favouriteButton.tintColor = viewModel.isFavourite ? .white : .lightGray
        favouriteButton.backgroundColor = viewModel.isFavourite ? .primary : .white
    }
    
    override func setEditing(_ editing: Bool, animated: Bool) {
        guard editing else { return }
        debugPrint("Start Editing")
        viewModel.didSelectEdit()
    }
}

extension PreviewContactViewController: PreviewContactViewModelDelegate {
    func viewModelDidFinishLoadingData(_ viewModel: PreviewContactViewModel) {
        tableView.reloadData()
        reloadData()
    }
}
