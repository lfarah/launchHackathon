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
    
    var activityList: [Activity] = []
    
    init(frame: CGRect, data activities : [Activity]) {
        super.init(frame: frame)
        activityList = activities
        
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
        cell.nameLabel?.text = activityList[indexPath.row].name
        cell.distanceLabel.text = String(activityList[indexPath.row].distanceFromHotel) + " miles"
        cell.profileImageView.image = UIImage(data: NSData(contentsOfURL: NSURL(string: activityList[indexPath.row].image)!)!)
        cell.rating.rating = Double(activityList[indexPath.row].rating)
        cell.address.text = activityList[indexPath.row].address
        
        return cell
    }
    
    func tableView(tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        //datasource method returning no. of rows
        return activityList.count
    }
    
    func tableView(tableView: UITableView, heightForRowAtIndexPath indexPath: NSIndexPath) -> CGFloat {
        return 90
    }
    
    func tableView(tableView: UITableView, canEditRowAtIndexPath indexPath: NSIndexPath) -> Bool {
        return false
    }
   
}

