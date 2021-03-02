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
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        view.backgroundColor = .systemBackground
        
        signOutBtn = UIButton(frame: CGRect(x: view.center.x - 50, y: view.center.y - 24, width: 100, height: 36))
        signOutBtn.addTarget(self, action: #selector(self.didTapSignOut), for: .touchUpInside)
        signOutBtn.setTitle("Sign out", for: .normal)
        signOutBtn.backgroundColor = .black
        
        view.addSubview(signOutBtn)
    
        
    }
    
    @objc func didTapSignOut(){
        GIDSignIn.sharedInstance()?.signOut()
        let vc = LoginViewController()
        vc.modalPresentationStyle = .fullScreen
        self.present(vc, animated: true)
    }
}
