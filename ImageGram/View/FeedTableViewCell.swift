//
//  FeedTableViewCell.swift
//  ImageGram
//
//  Created by Jabari Bell on 3/18/17.
//  Copyright © 2017 theowl. All rights reserved.
//

import Foundation
import SnapKit
import UIKit


/**
 * TableViewCell that contains the imageView and the title label.
 * Note: I declined to use the textLabel and the imageView that come
 *       with UITableViewCell for free because I like to see all
 *       properties listed out explicitly.  I feel it makes the code
 *       read more expressively.
 */
class FeedTableViewCell: UITableViewCell {

    //MARK: Property
    static let identifier = "FeedTableViewCellIdentifier"

    let photoImageView = UIImageView(frame: .zero)
    var photoTitle: String = "" {
        didSet {
            photoTitleLabel.text = photoTitle
        }
    }
    private let photoTitleLabel = UILabel(frame: .zero)


    //MARK: Method
    override init(style: UITableViewCellStyle, reuseIdentifier: String?) {
        super.init(style: style, reuseIdentifier: reuseIdentifier)
        setup()
    }

    required init?(coder aDecoder: NSCoder) {
        super.init(coder: aDecoder)
        setup()
    }

    private func setup() {
        backgroundColor = .clear
        selectionStyle = .none
        
        let bkgrndView = UIView(frame: .zero)
        bkgrndView.backgroundColor = UIColor(white: 0, alpha: 0.4)
        bkgrndView.layer.cornerRadius = 10
        contentView.addSubview(bkgrndView)
        bkgrndView.snp.makeConstraints { make in
            make.left.right.equalTo(contentView).inset(20)
            make.top.bottom.equalTo(contentView).inset(10)
        }
        
        let horizontalInset = 32
        contentView.addSubview(photoImageView)
        photoImageView.snp.makeConstraints { make in
            make.centerY.equalTo(contentView)
            make.width.height.equalTo(150)
            make.left.equalTo(contentView).inset(horizontalInset)
        }
        photoImageView.layer.cornerRadius = 10
        photoImageView.clipsToBounds = true
        photoImageView.layer.borderColor = UIColor.white.cgColor
        photoImageView.layer.borderWidth = 3

        photoTitleLabel.lineBreakMode = .byWordWrapping
        photoTitleLabel.numberOfLines = 0
        photoTitleLabel.textColor = .white
        photoTitleLabel.font = UIFont.ralewayExtraLightFontWithSize(20)
        contentView.addSubview(photoTitleLabel)
        photoTitleLabel.snp.makeConstraints { make in
            make.top.equalTo(photoImageView)
            make.left.equalTo(photoImageView.snp.right).offset(16)
            make.right.equalTo(contentView).inset(horizontalInset)
        }
    }
}
