//
//  ContactListViewController.swift
//  ContactApp
//
//  Created by Mohshin on 26/7/21.
//

import UIKit

class ContactListViewController: UITableViewController {
    
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
        let addBarButtonItem = UIBarButtonItem(barButtonSystemItem: .add, target: self, action: nil)
                
        navigationItem.leftBarButtonItem = groupsBarButtonItem
        navigationItem.rightBarButtonItem = addBarButtonItem
    
        navigationController?.navigationBar.shadowImage = nil
        
        tableView.tableFooterView = UIView()
        refreshControl = UIRefreshControl(frame: .zero)
        refreshControl?.addTarget(self, action: #selector(reloadData), for: .valueChanged)
    }
    
    @objc private func reloadData() {
        viewModel.loadData()
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
    
    override func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        tableView.deselectRow(at: indexPath, animated: true)
        viewModel.didSelectRow(at: indexPath)
    }
}

extension ContactListViewController: ContactListViewModelDelegate {
    func viewModelDidFinishLoadingWithSuccess(_ viewModel: ContactListViewModel) {
        refreshControl?.endRefreshing()
        tableView.reloadData()
    }

    func viewModel(_ viewModel: ContactListViewModel, didFinishLoadingWithError error: Error) {
        refreshControl?.endRefreshing()
        showAlert(with: "Error", message: error.localizedDescription)
    }
}
