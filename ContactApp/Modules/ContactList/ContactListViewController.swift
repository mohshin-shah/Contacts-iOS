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
    }
    
    @objc private func onAddContact() {
        //TODO: Open add contact screen
    }

    // MARK: - Table view data source

    override func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        viewModel.numberOfContacts()
    }

    
    override func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "ContactListCell", for: indexPath)
        guard let cellViewModel = viewModel.contactCellViewModelAt(indexPath: indexPath) else { return cell }
        cell.textLabel?.text = cellViewModel.fullName
        return cell
    }
}
