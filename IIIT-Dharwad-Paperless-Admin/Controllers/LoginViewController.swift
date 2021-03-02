//
//  ViewController.swift
//  trial
//
//  Created by Souvik Das on 16/01/21.
//

import UIKit
import GoogleSignIn

class LoginViewController: UIViewController {
    
    private var loginObserver: NSObjectProtocol?
    private var collectionView: UICollectionView!
    private var activityIndicator: UIActivityIndicatorView!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        view.backgroundColor = .systemBackground

        let barHeight: CGFloat = UIApplication.shared.statusBarFrame.height
        let navBarHeight: CGFloat = self.navigationController?.navigationBar.frame.height ?? 0
        let displayWidth: CGFloat = self.view.frame.width
        let displayHeight: CGFloat = self.view.frame.height
        
        let layout = UICollectionViewFlowLayout()
        layout.scrollDirection = .vertical
        layout.minimumLineSpacing = 1
        layout.minimumInteritemSpacing = 1
        layout.itemSize = CGSize(width: displayWidth, height: displayHeight)

        collectionView = UICollectionView(frame: CGRect(x: 0, y: navBarHeight + barHeight, width: displayWidth, height: displayHeight - navBarHeight - barHeight), collectionViewLayout: layout)
        
        collectionView.register(LoginCollectionViewCell.self, forCellWithReuseIdentifier: LoginCollectionViewCell.loginIdentifier)
        collectionView.backgroundColor = .systemBackground
        collectionView.showsVerticalScrollIndicator = false
        collectionView.delegate = self
        collectionView.dataSource = self
        
        activityIndicator = UIActivityIndicatorView(frame: CGRect(x: displayWidth/2 - 24, y: displayHeight/2 - 24, width: 48, height: 48))
        activityIndicator.isHidden = true
        
        view.addSubview(collectionView)
        view.addSubview(activityIndicator)
        
        loginObserver = NotificationCenter.default.addObserver(forName: .didLogInNotification, object: nil, queue: .main, using: { [weak self] _ in
            guard self != nil else {
                return
            }
            let vc = TabBarViewController()
//            vc.title = "Home"
            vc.modalPresentationStyle = .fullScreen
            self?.present(vc, animated: true)
            
        })
        
        GIDSignIn.sharedInstance().presentingViewController = self
        GIDSignIn.sharedInstance()?.restorePreviousSignIn()
        

        
    }
    deinit {
        if let observer = loginObserver {
            NotificationCenter.default.removeObserver(observer)
        }
    }
    
}


extension LoginViewController: UICollectionViewDelegate, UICollectionViewDataSource{
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return 1
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        
        let cell = collectionView.dequeueReusableCell(withReuseIdentifier: LoginCollectionViewCell.loginIdentifier, for: indexPath) as! LoginCollectionViewCell
        cell.loginImage.image = UIImage(named: "college-img")
        cell.adminButton.addTarget(self, action: #selector(self.didTapAdmin), for: .touchUpInside)
        return cell
    }
    
}
extension LoginViewController {
    
    @objc func didTapAdmin(){
        let vc = UINavigationController(rootViewController: AdminViewController())
        vc.title = "Admin"
//        vc.modalPresentationStyle = .fullScreen
        self.present(vc, animated: true)
    }
    
}
