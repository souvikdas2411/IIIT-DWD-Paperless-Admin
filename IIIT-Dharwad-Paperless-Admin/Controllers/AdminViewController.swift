//
//  AdminViewController.swift
//  IIIT-Dharwad-Paperless-Admin
//
//  Created by Souvik Das on 01/03/21.
//

import UIKit
import FirebaseDatabase

class AdminViewController: UIViewController {

    private var tableView: UITableView!
    private var docs = [Admin]()
//    var filteredArray = [Admin]()
//    var searchController = UISearchController(searchResultsController: nil)
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        view.backgroundColor = .systemBackground
        
        let barHeight: CGFloat = UIApplication.shared.statusBarFrame.height
        let navBarHeight: CGFloat = self.navigationController?.navigationBar.frame.height ?? 0
        let tabBarHeight: CGFloat = self.tabBarController?.tabBar.frame.height ?? 0
        
        tableView = UITableView(frame: CGRect(x: 0, y: barHeight + navBarHeight, width: view.frame.width, height: view.frame.height - tabBarHeight),style: .insetGrouped)
        tableView.register(AdminTableViewCell.self, forCellReuseIdentifier: AdminTableViewCell.identifier)
        tableView.keyboardDismissMode = .onDrag
//        searchController.obscuresBackgroundDuringPresentation = false
//        searchController.searchBar.showsCancelButton = false
//        searchController.searchBar.showsScopeBar = true
//        searchController.searchResultsUpdater = self
//        searchController.searchBar.scopeButtonTitles = ["All", "Awaiting response", "Accepted", "Rejected", "Not submitted"]
//        searchController.searchBar.delegate = self
//        tableView.tableHeaderView = searchController.searchBar
        
        view.addSubview(tableView)
        
        startListening()
        
        tableView.delegate = self
        tableView.dataSource = self
        
    }
    private func startListening() {
        
        
        AuthManager.shared.getAll(completion: { [weak self] result in
            switch result {
            case .success(let docs):
                
                guard !docs.isEmpty else {
                    print("successfully got models empty")
                    return
                }
                print("successfully got models")
                self?.docs = docs
                
                DispatchQueue.main.async {
                    self?.tableView.reloadData()
                }
            case .failure(let error):
                print("failed to get convos: \(error)")
            }
        })
        
    }
}
extension AdminViewController: UITableViewDelegate, UITableViewDataSource{
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return docs.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: AdminTableViewCell.identifier, for: indexPath) as! AdminTableViewCell
        cell.statLabel.text = docs[indexPath.row].stat
        cell.emailLabel.text = docs[indexPath.row].email
        cell.link1Label.text = docs[indexPath.row].link1
        cell.link2Label.text = docs[indexPath.row].link2
        cell.link3Label.text = docs[indexPath.row].link3
        cell.accept.tag = indexPath.row
        cell.reject.tag = indexPath.row
        cell.accept.addTarget(self, action: #selector(self.didTapAccept(_:)), for: .touchUpInside)
        cell.reject.addTarget(self, action: #selector(self.didTapReject(_:)), for: .touchUpInside)
        if docs[indexPath.row].stat == "Accepted" {
            cell.statLabel.textColor = .green
        }
        else {
            cell.statLabel.textColor = .red
        }
        
        return cell
    }
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        return 310
    }
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        tableView.deselectRow(at: indexPath, animated: true)
    }
    @objc func didTapAccept(_ sender: UIButton){
        let safeEmail = AuthManager.safeEmail(emailAddress: docs[sender.tag].email)
        Database.database().reference().child("users/\(safeEmail)/stats").updateChildValues([
            "docStat": "Accepted",
        ])
    }
    @objc func didTapReject(_ sender: UIButton){
        let safeEmail = AuthManager.safeEmail(emailAddress: docs[sender.tag].email)
        Database.database().reference().child("users/\(safeEmail)/stats").updateChildValues([
            "docStat": "Rejected",
        ])
    }
}
//extension AdminViewController: UISearchResultsUpdating, UISearchBarDelegate {
//    func updateSearchResults(for searchController: UISearchController) {
//        let searchBar = searchController.searchBar
//        let scope = searchBar.scopeButtonTitles![searchBar.selectedScopeButtonIndex]
//        filterContentsforSearchText(searchText: searchController.searchBar.text!, scope: scope)
//    }
//    func searchBar(_ searchBar: UISearchBar, selectedScopeButtonIndexDidChange selectedScope: Int) {
//        searchController.isActive = true
//        filterContentsforSearchText(searchText: searchBar.text!, scope: searchBar.scopeButtonTitles![selectedScope])
//    }
//    func filterContentsforSearchText(searchText: String, scope: String = "All"){
//
//        filteredArray = docs.filter { filter in
//            let categoryMatch = (scope == "All") || (filter.stat == scope)
//            if searchText.isEmpty {
//                return categoryMatch
//            }
//            return categoryMatch && filter.email.lowercased().contains(searchText.lowercased())
//        }
//
//        tableView.reloadData()
//    }
//}
