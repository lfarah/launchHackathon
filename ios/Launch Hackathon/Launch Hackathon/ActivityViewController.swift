//
//  ActivityMapView.swift
//  Launch Hackathon
//
//  Created by Furkan Yilmaz on 27/02/16.
//  Copyright © 2016 Lucas Farah. All rights reserved.
//

import UIKit
import ArcGIS

class ActivityViewController: UIViewController {
    
    var containerView: UIView!
    var bannerView: UIView!
    var mapView: UIView!
    var activityTableView: ActivityTableView!
    
    var bannerHeight: CGFloat = 150
    
    var activityList: [Activity] = []
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        containerView = UIView(x: 0, y: 0, w: ez.screenWidth, h: ez.screenHeight)
        
        getData()
        
        createBannerView()
        createMapView()
        createTableView()
        
        view.addSubview(containerView)
    }
    
    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
    override func prefersStatusBarHidden() -> Bool {
        return true
    }
    
    func createBannerView() {
        bannerView = UIView(x: 0, y: 0, w: ez.screenWidth, h: bannerHeight)
        
        let bannerImageView = UIImageView(x: 0, y: 0, w: bannerView.w, h: bannerView.h)
        bannerImageView.image = UIImage(named: "Bitmap")
        bannerImageView.contentMode = .ScaleToFill
        bannerView.addSubview(bannerImageView)
        
        let bannerLabel = UILabel(x: 50, y: 50, w: 0, h: 30, fontSize: 32)
        bannerLabel.text = "San Francisco"
        bannerLabel.textColor = UIColor.whiteColor()
        bannerLabel.fitWidth()
        bannerView.addSubview(bannerLabel)
        
        let bannerButton = UIButton(x: bannerView.rightOffset(-80), y: bannerView.bottomOffset(-40), w: 70, h: 30)
        bannerButton.backgroundColor = UIColor(r: 71, g: 161, b: 204)
        bannerButton.layer.cornerRadius = 6
        bannerButton.setTitle("LIST", forState: UIControlState.Normal)
        bannerButton.setTitle("MAP", forState: UIControlState.Selected)
        bannerButton.titleLabel?.font = UIFont(name: "HelveticaNeue", size: 14)
        bannerButton.addTapGesture { (tap) -> () in
            if bannerButton.selected {
                // Go to map view
                print("Go to map view")
                self.mapView.hidden = false
                self.activityTableView.hidden = true
            } else {
                // Go to list view
                print("Go to list view")
                self.mapView.hidden = true
                self.activityTableView.hidden = false
                self.activityTableView.tableView.reloadData()
            }
            bannerButton.selected.toggle()
        }
        bannerView.addSubview(bannerButton)
        
        containerView.addSubview(bannerView)
    }
    
    func createMapView() {
        mapView = ActivityMapView(frame: CGRect(x: containerView.x, y: bannerHeight, w: containerView.w, h: containerView.h - bannerHeight), data: activityList)
        containerView.addSubview(mapView)
    }
    
    func createTableView() {
        activityTableView = ActivityTableView(frame: CGRect(x: containerView.x, y: bannerHeight, w: containerView.w, h: containerView.h - bannerHeight), data: activityList)
        containerView.addSubview(activityTableView)
        activityTableView.hidden = true
    }
    
    func getData() {
        let jsonData = Network.getJSONData()
        for activity in jsonData {
            var newActivity = Activity()
            newActivity.address = activity["address"] as! String
            newActivity.name = activity["name"]as! String
            newActivity.bookWebsite = activity["bookWebsite"]as! String
            newActivity.description = activity["description"]as! String
            newActivity.distanceFromHotel = activity["distanceFromHotel"]as! Float
            newActivity.match = activity["match"]as! Float
            newActivity.price = activity["price"]as! Float
            newActivity.rating = activity["rating"]as! Float
            newActivity.ratingName = activity["ratingName"]as! String
            newActivity.ratingDescription = activity["ratingDescription"]as! String
            newActivity.ratingStar = activity["ratingStar"]as! Int
            
            activityList.append(newActivity)
        }
    }
}