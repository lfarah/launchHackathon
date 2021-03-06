//
//  DemoCell.swift
//  FoldingCell
//
//  Created by Alex K. on 25/12/15.
//  Copyright © 2015 Alex K. All rights reserved.
//

import UIKit

class DemoCell: FoldingCell {
  
  @IBOutlet weak var detailAddress: UILabel!
  @IBOutlet weak var viewColor: UIView!
  @IBOutlet weak var detailDescription: UILabel!
  @IBOutlet weak var cont: UIView!
  @IBOutlet weak var barView: UIView!
  
  
  //Closed cell
  @IBOutlet weak var lblNameActivity: UILabel!
  @IBOutlet weak var detailImageCity: UIImageView!
  @IBOutlet weak var lblDistanceActivity: UILabel!
  
  @IBOutlet weak var lblAddressActivity: UILabel!
  
  @IBOutlet weak var lblPriceActivity: UILabel!
  
  
  @IBOutlet weak var detailName: UILabel!
  @IBOutlet weak var detailMatch: UILabel!
  @IBOutlet weak var detailPrice: UILabel!
  @IBOutlet weak var detailRatingName: UILabel!
  @IBOutlet weak var detailRatingDescription: UILabel!
  
  
  
  override func awakeFromNib() {
    
//    foregroundView.layer.cornerRadius = 10
//    foregroundView.layer.masksToBounds = true
    
    viewColor.layer.cornerRadius = 10
    viewColor.layer.masksToBounds = true
    
    cont.layer.cornerRadius = 10
    cont.layer.masksToBounds = true

    
    barView.layer.cornerRadius = 10
    barView.layer.masksToBounds = true

    super.awakeFromNib()
  }
  
  override func animationDuration(itemIndex:NSInteger, type:AnimationType)-> NSTimeInterval {
    
    let durations = [0.26, 0.2, 0.2]
    return durations[itemIndex]
  }
  
}
