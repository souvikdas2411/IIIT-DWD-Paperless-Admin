//
//  HomeViewController.swift
//  IIIT-Dharwad-Paperless-Admin
//
//  Created by Souvik Das on 01/03/21.
//

import UIKit
import FirebaseDatabase

class HomeViewController: UIViewController {

    private var tableView: UITableView!
    private var docs = [Documents]()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        view.backgroundColor = .systemBackground
        
        tableView = UITableView(frame: CGRect(x: 0, y: 0, width: view.frame.width, height: view.frame.height),style: .insetGrouped)
        tableView.register(StatusTableViewCell.self, forCellReuseIdentifier: StatusTableViewCell.identifier)
//        tableView.backgroundColor = .systemBackground
        
        view.addSubview(tableView)
        
        startListeningForStat()
        
        tableView.delegate = self
        tableView.dataSource = self

    }
    private func startListeningForStat() {
        
        guard let email = UserDefaults.standard.value(forKey: "email") as? String else {
            return
        }
        
        let safeEmail = AuthManager.safeEmail(emailAddress: email)
        
        AuthManager.shared.getStat(for: safeEmail, completion: { [weak self] result in
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
extension HomeViewController: UITableViewDelegate, UITableViewDataSource{
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return docs.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: StatusTableViewCell.identifier, for: indexPath) as! StatusTableViewCell
        cell.statLabel.text = docs[indexPath.row].stat
        cell.link1Label.text = docs[indexPath.row].link1
        cell.link2Label.text = docs[indexPath.row].link2
        cell.link3Label.text = docs[indexPath.row].link3
        if docs[indexPath.row].stat == "Accepted" {
            cell.statLabel.textColor = .green
        }
        else {
            cell.statLabel.textColor = .red
        }
        
        return cell
    }
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        return 185
    }
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        tableView.deselectRow(at: indexPath, animated: true)        
    }
    

    
    
}
