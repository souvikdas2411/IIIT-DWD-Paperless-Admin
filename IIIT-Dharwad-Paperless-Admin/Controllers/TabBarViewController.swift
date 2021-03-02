//
//  TabBarViewController.swift
//  IIIT-Dharwad-Paperless-Admin
//
//  Created by Souvik Das on 01/03/21.
//

import UIKit

class TabBarViewController: UITabBarController {

    override func viewDidLoad() {
        super.viewDidLoad()

        let vc1 = HomeViewController()
        let vc2 = UploadViewController()
        let vc3 = ProfileViewController()
        let vc4 = AdminViewController()
        
        vc1.title = "Status"
        vc2.title = "Submit"
        vc3.title = "Profile"
        vc4.title = "Admin"
        
        vc1.navigationItem.largeTitleDisplayMode = .always
        vc2.navigationItem.largeTitleDisplayMode = .always
        vc3.navigationItem.largeTitleDisplayMode = .always
        vc4.navigationItem.largeTitleDisplayMode = .never
        
        let nav1 = UINavigationController(rootViewController: vc1)
        let nav2 = UINavigationController(rootViewController: vc2)
        let nav3 = UINavigationController(rootViewController: vc3)
        let nav4 = UINavigationController(rootViewController: vc4)
        
        nav1.tabBarItem = UITabBarItem(title: "Status", image: UIImage(systemName: "bonjour"), tag: 1)
        nav2.tabBarItem = UITabBarItem(title: "Submit", image: UIImage(systemName: "arrow.up.circle"), tag: 2)
        nav3.tabBarItem = UITabBarItem(title: "Profile", image: UIImage(systemName: "person"), tag: 3)
        nav4.tabBarItem = UITabBarItem(title: "Admin", image: UIImage(systemName: "lock"), tag: 3)
        
        nav1.navigationBar.prefersLargeTitles = true
        nav2.navigationBar.prefersLargeTitles = true
        nav3.navigationBar.prefersLargeTitles = true
        nav4.navigationBar.prefersLargeTitles = false

        setViewControllers([nav1, nav2, nav3, nav4], animated: true)
    }
}
