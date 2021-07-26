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
    
    override func viewDidLoad() {
        super.viewDidLoad()
        setUpBarButtonItems()
    }
    
    private func setUpBarButtonItems() {
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
        return 10
    }

    
    override func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "ContactListCell", for: indexPath)
        cell.textLabel?.text = "Cell \(indexPath.row)"
        return cell
    }
}
