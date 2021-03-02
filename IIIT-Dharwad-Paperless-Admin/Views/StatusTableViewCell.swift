//
//  ConversationTableViewCell.swift
//  Chatit
//
//  Created by Souvik Das on 12/12/20.
//

import UIKit


class StatusTableViewCell: UITableViewCell {

    static let identifier = "StatusTableViewCell"


    public let statLabel: UILabel = {
        let label = UILabel()
//        label.font = .systemFont(ofSize: 18, weight: .semibold)
        return label
    }()

    public let link1Label: UITextView = {
        let label = UITextView()
        label.font = .systemFont(ofSize: 15, weight: .thin)
//        label.numberOfLines = 0
        label.dataDetectorTypes = .link
        label.isEditable = false
        label.isSelectable = true
        return label
    }()
    public let link2Label: UITextView = {
        let label = UITextView()
        label.font = .systemFont(ofSize: 15, weight: .thin)
//        label.numberOfLines = 0
        label.dataDetectorTypes = .link
        label.isEditable = false
        label.isSelectable = true
        return label
    }()
    public let link3Label: UITextView = {
        let label = UITextView()
        label.font = .systemFont(ofSize: 15, weight: .thin)
//        label.numberOfLines = 0
        label.dataDetectorTypes = .link
        label.isEditable = false
        label.isSelectable = true
        return label
    }()

    override init(style: UITableViewCell.CellStyle, reuseIdentifier: String?) {
        super.init(style: style, reuseIdentifier: reuseIdentifier)
        contentView.addSubview(statLabel)
        contentView.addSubview(link1Label)
        contentView.addSubview(link2Label)
        contentView.addSubview(link3Label)
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

        link1Label.frame = CGRect(x: 10,
                                  y: statLabel.frame.maxY + 5,
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

    }
}
