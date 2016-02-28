//
//  ActivityCell.swift
//  Launch Hackathon
//
//  Created by Furkan Yilmaz on 27/02/16.
//  Copyright © 2016 Lucas Farah. All rights reserved.
//

import UIKit
import Cosmos

class ActivityCell: UITableViewCell {
    
    let padding: CGFloat = 5
    var nameLabel: UILabel!
    var profileImageView: UIImageView!
    var distanceLabel: UILabel!
    var rating: CosmosView!
    var address: UILabel!
    var type: UILabel!
    
    var whiteRoundedCornerView: UIView!
    
    override init(style: UITableViewCellStyle, reuseIdentifier: String?) {
        super.init(style: style, reuseIdentifier: reuseIdentifier)
        backgroundColor = UIColor.clearColor()
        selectionStyle = .None
        
        whiteRoundedCornerView = UIView(x: 10, y: 5, w: ez.screenWidth - 20, h: 90)
        whiteRoundedCornerView.backgroundColor = UIColor.clearColor()
//        whiteRoundedCornerView.layer.masksToBounds = false
//        whiteRoundedCornerView.layer.cornerRadius = 2
        
        contentView.addSubview(whiteRoundedCornerView)
        contentView.sendSubviewToBack(whiteRoundedCornerView)
        
        profileImageView = UIImageView(x: 15, y: 10, w: 70, h: 70)
        profileImageView.image = UIImage()
        profileImageView.layer.cornerRadius = 6
        profileImageView.layer.masksToBounds = true
        contentView.addSubview(profileImageView)
        
        nameLabel = UILabel(x: profileImageView.rightOffset(10), y: -20, w: frame.width, h: 20)
        nameLabel.textAlignment = .Left
        nameLabel.textColor = UIColor.blackColor()
        contentView.addSubview(nameLabel)
        
        rating = CosmosView(x: profileImageView.rightOffset(10), y: nameLabel.bottomOffset(-30), w: frame.width, h: 20)
        rating.settings.fillMode = .Precise
        rating.settings.starSize = 16
        rating.settings.starMargin = 3
        rating.settings.filledColor = UIColor.orangeColor()
        rating.settings.emptyBorderColor = UIColor.orangeColor()
        rating.settings.filledBorderColor = UIColor.orangeColor()
        rating.settings.updateOnTouch = false
        contentView.addSubview(rating)
        
        address = UILabel(x: profileImageView.rightOffset(10), y: rating.bottomOffset(-15), w: frame.width, h: 20)
        address.textAlignment = .Left
        address.textColor = UIColor.blackColor()
        address.font = UIFont(name: FontName.HelveticaNeue.rawValue, size: 14)
        contentView.addSubview(address)
        
        distanceLabel = UILabel(x: whiteRoundedCornerView.leftOffset(40), y: -15, w: frame.width, h: 20)
        distanceLabel.textAlignment = .Right
        distanceLabel.font = UIFont(name: FontName.HelveticaNeue.rawValue, size: 14)
        distanceLabel.textColor = UIColor.grayColor()
        contentView.addSubview(distanceLabel)
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
        distanceLabel.frame = CGRectMake(whiteRoundedCornerView.leftOffset(40), whiteRoundedCornerView.topOffset(-8), frame.width, 20)
        nameLabel.frame = CGRectMake(profileImageView.rightOffset(10), whiteRoundedCornerView.topOffset(-8), 220, 20)
        rating.frame = CGRectMake(profileImageView.rightOffset(10), nameLabel.bottomOffset(5), frame.width, 20)
        address.frame = CGRectMake(profileImageView.rightOffset(10), rating.bottom, frame.width, 20)

    }
}

