//
//  YogaDetailsCollectionViewCell.swift
//  trial
//
//  Created by Souvik Das on 16/01/21.
//

import UIKit
import GoogleSignIn

class LoginCollectionViewCell: UICollectionViewCell {
    
    static let loginIdentifier = "LoginCell"
    
    var loginImage: UIImageView = {
        let imageView = UIImageView()
        imageView.translatesAutoresizingMaskIntoConstraints = false
        return imageView
    }()
    var googleButton: GIDSignInButton = {
        let button = GIDSignInButton()
        button.translatesAutoresizingMaskIntoConstraints = false
        return button
    }()
    var adminButton: UIButton = {
        let button = UIButton()
        button.translatesAutoresizingMaskIntoConstraints = false
        button.backgroundColor = .red
        button.setTitle("Admin Login?", for: .normal)
        return button
    }()
    override init(frame: CGRect) {
        super .init(frame: frame)
        contentView.addSubview(loginImage)
        contentView.addSubview(googleButton)
//        contentView.addSubview(adminButton)
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    override func layoutSubviews() {
        loginImage.topAnchor.constraint(equalTo: contentView.centerYAnchor, constant: 0).isActive = true
        loginImage.leadingAnchor.constraint(equalTo: contentView.leadingAnchor, constant:10).isActive = true
        loginImage.heightAnchor.constraint(equalToConstant: 50).isActive = true
        loginImage.widthAnchor.constraint(equalToConstant: 100).isActive = true
        
        
        googleButton.topAnchor.constraint(equalTo: contentView.centerYAnchor, constant: 0).isActive = true
        googleButton.leadingAnchor.constraint(equalTo: loginImage.trailingAnchor, constant: 20).isActive = true
        googleButton.trailingAnchor.constraint(equalTo: contentView.trailingAnchor, constant: 0).isActive = true
        
//        adminButton.topAnchor.constraint(equalTo: contentView.topAnchor, constant: 10).isActive = true
//        adminButton.leadingAnchor.constraint(equalTo: contentView.leadingAnchor, constant:10).isActive = true
//        adminButton.trailingAnchor.constraint(equalTo: contentView.trailingAnchor, constant:-10).isActive = true
    }
    
}

