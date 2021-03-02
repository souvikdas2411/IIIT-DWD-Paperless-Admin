//
//  YogaDetailsViewController.swift
//  trial
//
//  Created by Souvik Das on 16/01/21.
//

import UIKit
import SwiftyJSON
import SDWebImage

class YogaDetailsViewController: UIViewController {

    public var titleDet = ""
        
    var yoga = [yogaJson]()
    
    private var collectionView: UICollectionView!
    private var activityIndicator: UIActivityIndicatorView!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        view.backgroundColor = .systemBackground
        self.title = "Details".localizableString(loc: UserDefaults.standard.string(forKey: "lang")!)

        let barHeight: CGFloat = UIApplication.shared.statusBarFrame.height
        let navBarHeight: CGFloat = self.navigationController?.navigationBar.frame.height ?? 0
        let displayWidth: CGFloat = self.view.frame.width
        let displayHeight: CGFloat = self.view.frame.height
        
        let layout = UICollectionViewFlowLayout()
        layout.scrollDirection = .vertical
        layout.minimumLineSpacing = 1
        layout.minimumInteritemSpacing = 1
        layout.estimatedItemSize = CGSize(width: displayWidth, height: displayHeight)

        collectionView = UICollectionView(frame: CGRect(x: 0, y: navBarHeight + 10, width: displayWidth, height: displayHeight - navBarHeight - barHeight - 35), collectionViewLayout: layout)
        
        collectionView.register(YogaDetailsCollectionViewCell.self, forCellWithReuseIdentifier: YogaDetailsCollectionViewCell.yogaDetailsIdentifier)
        collectionView.backgroundColor = .systemBackground
        
        activityIndicator = UIActivityIndicatorView(frame: CGRect(x: displayWidth/2 - 24, y: displayHeight/2 - 24, width: 48, height: 48))
        
        view.addSubview(collectionView)
        view.addSubview(activityIndicator)
        
        getData(source: "https://uptodd.com/api/yoga?lang=\(String(UserDefaults.standard.string(forKey: "api-lang")!))")
        
    }
}
extension YogaDetailsViewController {
    func getData(source: String){
        
        activityIndicator.isHidden = false
        activityIndicator.startAnimating()
        
        let url = URL(string: source)!
        let session = URLSession(configuration: .default)
        session.dataTask(with: url){ (data, _, error) in
            if error != nil{
                print(error?.localizedDescription as Any)
                return
            }

            guard let json = try? JSON(data: data!) else {
                return
            }
            for i in json["data"] {
                let image = i.1["image"].stringValue
                let id = i.1["id"].stringValue
                let description = i.1["description"].stringValue
                let name = i.1["steps"].stringValue
 
                DispatchQueue.main.async {
                    
                    if i.1["name"].stringValue == self.titleDet {
                        self.yoga.append(yogaJson(id: id, desc: description, name: name, image: image))
                    }
                    
                    self.activityIndicator.isHidden = true
                    self.activityIndicator.stopAnimating()
                    self.collectionView.delegate = self
                    self.collectionView.dataSource = self
                    self.collectionView.reloadData()
                    
                }
                
            }

            
        }.resume()
        
    }
}

extension YogaDetailsViewController: UICollectionViewDelegate, UICollectionViewDataSource{
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return yoga.count
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        
        let cell = collectionView.dequeueReusableCell(withReuseIdentifier: YogaDetailsCollectionViewCell.yogaDetailsIdentifier, for: indexPath) as! YogaDetailsCollectionViewCell
        cell.desc.text = yoga[indexPath.row].desc
        cell.title.text = yoga[indexPath.row].name
        let originalString = "https://uptodd.com/images/app/ios/details/yoga/\(yoga[indexPath.row].image).png"
        let urlString = originalString.addingPercentEncoding(withAllowedCharacters: .urlQueryAllowed)
        cell.yogaImage.sd_setImage(with: URL(string: urlString!), completed: nil)
        cell.yogaImage.layer.masksToBounds = true
        cell.layer.masksToBounds = true
//        cell.layer.backgroundColor = UIColor.red.cgColor
        return cell
    }
    
}
