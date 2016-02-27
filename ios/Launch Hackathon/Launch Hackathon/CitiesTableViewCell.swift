//
//  CitiesTableViewCell.swift
//  Launch Hackathon
//
//  Created by Lucas Farah on 2/27/16.
//  Copyright © 2016 Lucas Farah. All rights reserved.
//

import UIKit

class CitiesTableViewCell: UITableViewCell {

  @IBOutlet weak var lblCity: UILabel!
  @IBOutlet weak var viewColor: UIView!
  @IBOutlet weak var imgvCity: UIImageView!
    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
    }

    override func setSelected(selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)

        // Configure the view for the selected state
    }

}
