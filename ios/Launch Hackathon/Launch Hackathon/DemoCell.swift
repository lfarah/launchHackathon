//
//  DemoCell.swift
//  FoldingCell
//
//  Created by Alex K. on 25/12/15.
//  Copyright © 2015 Alex K. All rights reserved.
//

import UIKit

class DemoCell: FoldingCell {
  
  @IBOutlet weak var viewColor: UIView!
  @IBOutlet weak var cont: UIView!
  @IBOutlet weak var barView: UIView!
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
