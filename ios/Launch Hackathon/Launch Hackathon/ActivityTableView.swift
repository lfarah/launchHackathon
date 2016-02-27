//
//  ActivitiesTableVC.swift
//  Launch Hackathon
//
//  Created by Furkan Yilmaz on 26/02/16.
//  Copyright © 2016 Lucas Farah. All rights reserved.
//

import UIKit
import ArcGIS

class ActivityTableView: UIView {
    
    var tableView: UITableView!
    
    var cityData: [String] = []
    
    init(frame: CGRect, data someData : [String]) {
        super.init(frame: frame)
        cityData = someData
        
        self.backgroundColor = UIColor.grayColor()
        self.createTableView()
    }
    
    required init(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    func createTableView() {
        tableView = UITableView(x: 0, y: 0, w: w, h: h)
        tableView.delegate      =   self
        tableView.dataSource    =   self
        tableView.separatorStyle = UITableViewCellSeparatorStyle.SingleLine
        tableView!.registerClass(ActivityCell.self, forCellReuseIdentifier: NSStringFromClass(ActivityCell))
        self.addSubview(tableView)
    }

}

extension ActivityTableView: UITableViewDelegate, UITableViewDataSource {
    func tableView(tableView: UITableView, cellForRowAtIndexPath indexPath: NSIndexPath) -> UITableViewCell {
        //datasource method returning the what cell contains
        let cell = tableView.dequeueReusableCellWithIdentifier( NSStringFromClass(ActivityCell), forIndexPath: indexPath) as! ActivityCell
        cell.nameLabel?.text = cityData[indexPath.row]
        cell.distanceLabel.text = "1.8 mi"
        cell.profileImageView.image = UIImage(named: "Bitmap")
        cell.rating.rating = 4
        cell.address.text = "Hwy 101, Presidio"
        
        return cell
    }
    
    func tableView(tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        //datasource method returning no. of rows
        return cityData.count
    }
    
    func tableView(tableView: UITableView, heightForRowAtIndexPath indexPath: NSIndexPath) -> CGFloat {
        return 90
    }
    
    func tableView(tableView: UITableView, canEditRowAtIndexPath indexPath: NSIndexPath) -> Bool {
        return false
    }
   
}

