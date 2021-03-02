//
//  AdminTableViewCell.swift
//  IIIT-Dharwad-Paperless-Admin
//
//  Created by Souvik Das on 01/03/21.
//

import UIKit

class AdminTableViewCell: UITableViewCell {

    static let identifier = "AdminTableViewCell"


    public let statLabel: UILabel = {
        let label = UILabel()
        return label
    }()
    public let emailLabel: UILabel = {
        let label = UILabel()
        label.font = .systemFont(ofSize: 18, weight: .semibold)
        return label
    }()

    public let link1Label: UITextView = {
        let label = UITextView()
        label.font = .systemFont(ofSize: 15, weight: .thin)
        label.dataDetectorTypes = .link
        label.isEditable = false
        label.isSelectable = true
        return label
    }()
    public let link2Label: UITextView = {
        let label = UITextView()
        label.font = .systemFont(ofSize: 15, weight: .thin)
        label.dataDetectorTypes = .link
        label.isEditable = false
        label.isSelectable = true
        return label
    }()
    public let link3Label: UITextView = {
        let label = UITextView()
        label.font = .systemFont(ofSize: 15, weight: .thin)
        label.dataDetectorTypes = .link
        label.isEditable = false
        label.isSelectable = true
        return label
    }()
    
    public let accept: UIButton = {
        let label = UIButton()
        label.setTitle("Accept", for: .normal)
        label.backgroundColor = .green
        return label
    }()
    
    public let reject: UIButton = {
        let label = UIButton()
        label.setTitle("Reject", for: .normal)
        label.backgroundColor = .red
        return label
    }()

    override init(style: UITableViewCell.CellStyle, reuseIdentifier: String?) {
        super.init(style: style, reuseIdentifier: reuseIdentifier)
        contentView.addSubview(statLabel)
        contentView.addSubview(emailLabel)
        contentView.addSubview(link1Label)
        contentView.addSubview(link2Label)
        contentView.addSubview(link3Label)
        contentView.addSubview(accept)
        contentView.addSubview(reject)
    }

    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }

    override func layoutSubviews() {
        super.layoutSubviews()

        statLabel.frame = CGRect(x: 10,
                                     y: 10,
                                     width: contentView.frame.width - 20,
                                     height: 36)
        emailLabel.frame = CGRect(x: 10, y: statLabel.frame.maxY + 5, width: contentView.frame.width - 20, height: 36)

        link1Label.frame = CGRect(x: 10,
                                  y: emailLabel.frame.maxY + 5,
                                     width: contentView.frame.width - 20,
                                     height: 36)

        link2Label.frame = CGRect(x: 10,
                                  y: link1Label.frame.maxY + 5,
                                     width: contentView.frame.width - 20,
                                     height: 36)
        link3Label.frame = CGRect(x: 10,
                                  y: link2Label.frame.maxY + 5,
                                     width: contentView.frame.width - 20,
                                     height: 36)
        accept.frame = CGRect(x: contentView.frame.width - 110, y: link3Label.frame.maxY + 10, width: 100, height: 36)
        reject.frame = CGRect(x: contentView.frame.width - 110, y: accept.frame.maxY + 10, width: 100, height: 36)

    }
}
