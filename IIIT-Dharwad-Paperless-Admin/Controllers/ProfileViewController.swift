//
//  ProfileViewController.swift
//  IIIT-Dharwad-Paperless-Admin
//
//  Created by Souvik Das on 01/03/2021.
//

import UIKit
import GoogleSignIn

class ProfileViewController: UIViewController {

    private var signOutBtn: UIButton!
    private var emailLabel: UILabel!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        view.backgroundColor = .systemBackground
        
        let barHeight: CGFloat = UIApplication.shared.statusBarFrame.height
        let navBarHeight: CGFloat = self.navigationController?.navigationBar.frame.height ?? 0
        let tabBarHeight: CGFloat = self.tabBarController?.tabBar.frame.height ?? 0
        
        signOutBtn = UIButton(frame: CGRect(x: 10, y: view.frame.height - tabBarHeight - 41, width: view.frame.width - 20, height: 36))
        signOutBtn.addTarget(self, action: #selector(self.didTapSignOut), for: .touchUpInside)
        signOutBtn.setTitle("Sign out", for: .normal)
        signOutBtn.backgroundColor = .black
        
        emailLabel = UILabel(frame: CGRect(x: 0, y: barHeight + navBarHeight + 10, width: view.frame.width, height: 36))
        emailLabel.font = .systemFont(ofSize: 15, weight: .thin)
        emailLabel.text = UserDefaults.standard.value(forKey: "email") as? String
        emailLabel.textAlignment = .center
        
        view.addSubview(signOutBtn)
        view.addSubview(emailLabel)
    
        
    }
    
    @objc func didTapSignOut(){
        GIDSignIn.sharedInstance()?.signOut()
        let vc = LoginViewController()
        vc.modalPresentationStyle = .fullScreen
        self.present(vc, animated: true)
    }
}
