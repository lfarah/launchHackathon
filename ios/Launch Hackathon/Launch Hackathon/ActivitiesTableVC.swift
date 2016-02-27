//
//  ActivitiesTableVC.swift
//  Launch Hackathon
//
//  Created by Furkan Yilmaz on 26/02/16.
//  Copyright © 2016 Lucas Farah. All rights reserved.
//

import UIKit
import ArcGIS

class ActivitiesTableVC: UITableViewController {
    
//    var tableView: UITableView!
    
    var cityData: [String] = []
    
    init(data someData : [String]) {
        super.init(nibName: nil, bundle:nil)
        cityData = someData
    }
    
    required init(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        view.backgroundColor = UIColor.grayColor()
        
        createTableView()
    }
    
    func createTableView() {
        tableView = UITableView(x: 0, y: 0, w: ez.screenWidth, h: ez.screenHeight)
        tableView.delegate      =   self
        tableView.dataSource    =   self
        tableView!.registerClass(ActivityCell.self, forCellReuseIdentifier: NSStringFromClass(ActivityCell))
    }

    override func tableView(tableView: UITableView, cellForRowAtIndexPath indexPath: NSIndexPath) -> UITableViewCell {
        //datasource method returning the what cell contains
        let cell = tableView.dequeueReusableCellWithIdentifier( NSStringFromClass(ActivityCell), forIndexPath: indexPath) as! ActivityCell
        cell.nameLabel?.text = cityData[indexPath.row]
        cell.descriptionLabel.text = "This is a description"
        cell.countLabel.text = "5"
        cell.profileImageView.image = UIImage(named: "temp")
        
        return cell
    }
    
    override func tableView(tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        //datasource method returning no. of rows
        return cityData.count
    }
    
    override func tableView(tableView: UITableView, heightForRowAtIndexPath indexPath: NSIndexPath) -> CGFloat {
        return 90
    }
    
    override func tableView(tableView: UITableView, canEditRowAtIndexPath indexPath: NSIndexPath) -> Bool {
        return false
    }
}

