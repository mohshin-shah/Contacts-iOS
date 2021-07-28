//
//  EditContactViewController.swift
//  ContactApp
//
//  Created by Mohshin on 28/7/21.
//

import UIKit

class EditContactViewController: UITableViewController {

    override func viewDidLoad() {
        super.viewDidLoad()
        
        navigationItem.leftBarButtonItem = UIBarButtonItem(barButtonSystemItem: .cancel, target: self, action: #selector(onCancel))
        navigationItem.rightBarButtonItem = UIBarButtonItem(barButtonSystemItem: .done, target: self, action: #selector(onDone))
        tableView.tableFooterView = UIView()
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
