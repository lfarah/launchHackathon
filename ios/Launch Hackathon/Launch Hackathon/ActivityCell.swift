//
//  ActivityCell.swift
//  Launch Hackathon
//
//  Created by Furkan Yilmaz on 27/02/16.
//  Copyright © 2016 Lucas Farah. All rights reserved.
//

import UIKit

class ActivityCell: UITableViewCell {
    
    let padding: CGFloat = 5
    var nameLabel: UILabel!
    var descriptionLabel: UILabel!
    var profileImageView: UIImageView!
    var countLabel: UILabel!
    var whiteRoundedCornerView: UIView!
    
    override init(style: UITableViewCellStyle, reuseIdentifier: String?) {
        super.init(style: style, reuseIdentifier: reuseIdentifier)
        backgroundColor = UIColor.clearColor()
        selectionStyle = .None
        
        whiteRoundedCornerView = UIView(x: 10, y: 5, w: ez.screenWidth - 20, h: 80)
        whiteRoundedCornerView.backgroundColor = UIColor.whiteColor()
        whiteRoundedCornerView.layer.masksToBounds = false
        whiteRoundedCornerView.layer.cornerRadius = 6
        
        contentView.addSubview(whiteRoundedCornerView)
        contentView.sendSubviewToBack(whiteRoundedCornerView)
        
        profileImageView = UIImageView(x: 15, y: 10, w: 70, h: 70)
        profileImageView.image = UIImage()
        profileImageView.layer.cornerRadius = 35
        profileImageView.layer.masksToBounds = true
        contentView.addSubview(profileImageView)
        
        nameLabel = UILabel(x: profileImageView.rightOffset(10), y: whiteRoundedCornerView.top, w: frame.width, h: frame.height)
        nameLabel.textAlignment = .Left
        nameLabel.textColor = UIColor.blackColor()
        contentView.addSubview(nameLabel)
        
        descriptionLabel = UILabel(x: profileImageView.rightOffset(10), y: nameLabel.bottomOffset(5), w: frame.width, h: frame.height)
        descriptionLabel.textAlignment = .Left
        descriptionLabel.textColor = UIColor.blackColor()
        contentView.addSubview(descriptionLabel)
        
        countLabel = UILabel(x: whiteRoundedCornerView.leftOffset(10), y: 15, w: frame.width, h: frame.height)
        countLabel.textAlignment = .Right
        countLabel.textColor = UIColor.grayColor()
        contentView.addSubview(countLabel)
    }
    
    required init?(coder aDecoder: NSCoder) {
        super.init(coder: aDecoder)
        fatalError("init(coder:) has not been implemented")
    }
    
    override func prepareForReuse() {
        super.prepareForReuse()
    }
    
    override func layoutSubviews() {
        super.layoutSubviews()
        nameLabel.frame = CGRectMake(profileImageView.rightOffset(10), -15, frame.width, frame.height)
        descriptionLabel.frame = CGRectMake(profileImageView.rightOffset(10), nameLabel.bottomOffset(25), frame.width, frame.height)
        countLabel.frame = CGRectMake(whiteRoundedCornerView.leftOffset(40), 0, frame.width, frame.height)
    }
}

