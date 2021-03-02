//
//  UploadViewController.swift
//  IIIT-Dharwad-Paperless-Admin
//
//  Created by Souvik Das on 01/03/21.
//

import UIKit
import FirebaseDatabase

class UploadViewController: UIViewController {
    
    private var doc1: UITextField!
    private var doc2: UITextField!
    private var doc3: UITextField!
    private var sbtButton: UIButton!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        view.backgroundColor = .systemBackground
        
        let barHeight: CGFloat = UIApplication.shared.statusBarFrame.height
        let navBarHeight: CGFloat = self.navigationController?.navigationBar.frame.height ?? 0
        
        let tap = UITapGestureRecognizer(target: self, action: #selector(UIInputViewController.dismissKeyboard))
        tap.cancelsTouchesInView = false
        view.addGestureRecognizer(tap)
        
        
        doc1 = UITextField(frame: CGRect(x: 10, y: barHeight + navBarHeight + 10, width: view.frame.width - 20, height: 36))
        doc2 = UITextField(frame: CGRect(x: 10, y: doc1.frame.maxY + 10, width: view.frame.width - 20, height: 36))
        doc3 = UITextField(frame: CGRect(x: 10, y: doc2.frame.maxY + 10, width: view.frame.width - 20, height: 36))
        
        doc1.borderStyle = .roundedRect
        doc2.borderStyle = .roundedRect
        doc3.borderStyle = .roundedRect
        
        doc1.placeholder = "Marks Sheet Link"
        doc2.placeholder = "Aadhar Card Link"
        doc3.placeholder = "Random ID Link"
        
        doc1.textContentType = .URL
        doc2.textContentType = .URL
        doc3.textContentType = .URL
        
        sbtButton = UIButton(frame: CGRect(x: view.frame.width - 110, y: doc3.frame.maxY + 15, width: 100, height: 36))
        sbtButton.setTitle("Submit", for: .normal)
        sbtButton.backgroundColor = .black
        sbtButton.addTarget(self, action: #selector(self.didTapSubmit), for: .touchUpInside)
        
        view.addSubview(doc1)
        view.addSubview(doc2)
        view.addSubview(doc3)
        view.addSubview(sbtButton)
        
    }
    
    @objc func dismissKeyboard() {
        //Causes the view (or one of its embedded text fields) to resign the first responder status.
        view.endEditing(true)
    }
    @objc func didTapSubmit() {
        
        if doc1.text == "" && doc2.text == "" && doc3.text == "" {
            let alert = UIAlertController(title: "Error", message: "Please fill in all the details", preferredStyle: .alert)
            alert.addAction(UIAlertAction(title: "Dismiss", style: .default, handler: { [weak self] _ in
                alert.dismiss(animated: true, completion: nil)
            }))
            self.present(alert, animated: true, completion: nil)
            return
        }
        guard let email = UserDefaults.standard.value(forKey: "email") as? String else {
            return
        }
        
        let safeEmail = AuthManager.safeEmail(emailAddress: email)
        let link1 = doc1.text
        let link2 = doc2.text
        let link3 = doc3.text
        Database.database().reference().child("users/\(safeEmail)/stats").updateChildValues([
            "docStat": "Awaiting Response",
            "link1": link1,
            "link2": link2,
            "link3": link3
        ])
        doc1.text = ""
        doc2.text = ""
        doc3.text = ""
    }
}
