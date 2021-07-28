//
//  EditContactViewController.swift
//  ContactApp
//
//  Created by Mohshin on 28/7/21.
//

import UIKit

class EditContactViewController: UITableViewController {
    
    @IBOutlet weak var avatarImageView: UIImageView!
    
    @IBOutlet weak var firstNameTextField: UITextField!
    @IBOutlet weak var lastNameTextField: UITextField!
    
    @IBOutlet weak var mobileNumberTextField: UITextField!
    @IBOutlet weak var emailIDTextField: UITextField!

    @IBOutlet weak var headerViewContainer: UIView!

    var viewModel: EditContactViewModel!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        assert(viewModel != nil)
        setUpViews()
    }
    
    override func viewDidDisappear(_ animated: Bool) {
        super.viewDidDisappear(animated)
        viewModel.onViewDidDisappear()
    }
    
    private func setUpViews() {
        navigationController?.navigationBar.shadowImage = UIImage()
        navigationItem.leftBarButtonItem = UIBarButtonItem(barButtonSystemItem: .cancel, target: self, action: #selector(onCancel))
        navigationItem.rightBarButtonItem = UIBarButtonItem(barButtonSystemItem: .done, target: self, action: #selector(onDone))
        tableView.tableFooterView = UIView()
        
        // Disable Mobile number and email field as per requirement
        mobileNumberTextField.isEnabled = false
        emailIDTextField.isEnabled = false
        
        firstNameTextField.delegate = self
        lastNameTextField.delegate = self

        let gradientLayer = CAGradientLayer()
        gradientLayer.colors = [UIColor.white.cgColor, UIColor.primary.withAlphaComponent(0.4).cgColor]
        gradientLayer.frame = headerViewContainer.bounds
        headerViewContainer.layer.insertSublayer(gradientLayer, at: 0)

        avatarImageView.sd_setImage(with: viewModel.avatarURL)
        firstNameTextField.text = viewModel.firstName
        lastNameTextField.text = viewModel.lastName
        mobileNumberTextField.text = viewModel.mobileNumber
        emailIDTextField.text = viewModel.emailID
    }
    
    @objc private func onCancel() {
        debugPrint("Cancel clicked")
        dismiss(animated: true, completion: nil)
    }
    
    @objc private func onDone() {
        debugPrint("Done clicked")
        dismiss(animated: true, completion: nil)
    }
}

extension EditContactViewController: UITextFieldDelegate {
    func textFieldShouldReturn(_ textField: UITextField) -> Bool {
        switch textField {
        case firstNameTextField:
            viewModel.firstName = textField.text
        case lastNameTextField:
            viewModel.lastName = textField.text
        default:
            break
        }
        return true
    }
}
