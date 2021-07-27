//
//  ContactListViewController.swift
//  ContactApp
//
//  Created by Mohshin on 26/7/21.
//

import UIKit

class ContactListViewController: UITableViewController {
    
    static func instantiate() -> ContactListViewController {
        let storyboard = UIStoryboard(name: "Main", bundle: .main)
        let controller = storyboard.instantiateViewController(identifier: "ContactListViewController") as! ContactListViewController        
        return controller
    }
    
    var viewModel: ContactListViewModel!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        assert(viewModel != nil)
        viewModel.loadData()
        setUpViews()
    }
    
    private func setUpViews() {
        title = viewModel.title
        
        let groupsBarButtonItem = UIBarButtonItem(title: "Groups", style: .plain, target: nil, action: nil)
        let addBarButtonItem = UIBarButtonItem(barButtonSystemItem: .add, target: self, action: #selector(onAddContact))
        
        groupsBarButtonItem.tintColor = .primary
        addBarButtonItem.tintColor = .primary
        
        navigationItem.leftBarButtonItem = groupsBarButtonItem
        navigationItem.rightBarButtonItem = addBarButtonItem
        
        tableView.tableFooterView = UIView()
    }
    
    @objc private func onAddContact() {
        viewModel.onAddContact()
    }

    // MARK: - Table view data source

    override func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        viewModel.numberOfContacts()
    }

    
    override func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "ContactTableViewCell", for: indexPath) as! ContactTableViewCell
        guard let cellViewModel = viewModel.contactCellViewModelAt(indexPath: indexPath) else { return cell }
        cell.configure(using: cellViewModel)
        return cell
    }
}

extension ContactListViewController: ContactListViewModelDelegate {
    func updateListUI() {
        tableView.reloadData()
    }
    
    func showErrorUI(with errorMessage: String) {
        let alert = UIAlertController(title: "Error", message: errorMessage, preferredStyle: .alert)
        let okAction = UIAlertAction(title: "Okay", style: .default)
        alert.addAction(okAction)
        alert.view.tintColor = .primary
        present(alert, animated: true, completion: nil)
    }
}
