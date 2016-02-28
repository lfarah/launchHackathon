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
  
  var bannerHeight: CGFloat = 133
  
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
    
    let fakeNavigationBar = UIView(x: 0, y: 0, w: bannerView.w, h: 80)
    fakeNavigationBar.backgroundColor = UIColor(r: 40, g: 50, b: 57)
    
    let fakeNavigationBarTitle = UILabel(x: 0, y: 0, w: 0, h: 0)
    fakeNavigationBarTitle.text = "Maps"
    fakeNavigationBarTitle.font = UIFont(name: FontName.HelveticaNeue.rawValue, size: 22)
    fakeNavigationBarTitle.textColor = UIColor.whiteColor()
    fakeNavigationBarTitle.fitSize()
    fakeNavigationBarTitle.center = fakeNavigationBar.center
    fakeNavigationBar.addSubview(fakeNavigationBarTitle)
    
    let fakeNavigationBackButton = UIImageView( image: UIImage(named: "backbutton.png")!)
    fakeNavigationBackButton.scaleImageFrameToWidth(width: 12)
    fakeNavigationBackButton.center = CGPoint(x: 30, y: fakeNavigationBar.centerY)
    fakeNavigationBar.addSubview(fakeNavigationBackButton)
    
    fakeNavigationBackButton.addTapGesture { (gesture) -> () in
      // TODO:
      //            presentVC(asd)
    }
    
    let fakeNavigationSettingsButton = UIImageView( image: UIImage(named: "settings.png")!)
    fakeNavigationSettingsButton.scaleImageFrameToWidth(width: 22)
    fakeNavigationSettingsButton.center = CGPoint(x: fakeNavigationBar.w - 30, y: fakeNavigationBar.centerY)
    fakeNavigationBar.addSubview(fakeNavigationSettingsButton)
    
    fakeNavigationSettingsButton.addTapGesture { (gesture) -> () in
//        presentVC("")
        
        let possibleBaseMaps = ["http://server.arcgisonline.com/ArcGIS/rest/services/World_Topo_Map/MapServer", "http://server.arcgisonline.com/ArcGIS/rest/services/World_Street_Map/MapServer", "http://services.arcgisonline.com/ArcGIS/rest/services/Canvas/World_Light_Gray_Base/MapServer", "http://services.arcgisonline.com/ArcGIS/rest/services/NatGeo_World_Map/MapServer", "http://services.arcgisonline.com/ArcGIS/rest/services/Ocean_Basemap/MapServer", "http://services.arcgisonline.com/ArcGIS/rest/services/World_Terrain_Base/MapServer", "http://tiles.arcgis.com/tiles/IEuSomXfi6iB7a25/arcgis/rest/services/World_Globe_1790/MapServer", "http://tiles.arcgis.com/tiles/IEuSomXfi6iB7a25/arcgis/rest/services/World_Globe_1812/MapServer"]
        
        Network.baseMapURL = possibleBaseMaps.random()
        
        self.createMapView()
    }
    
    bannerView.addSubview(fakeNavigationBar)
    
    let subBar = UIView(x: 0, y: fakeNavigationBar.bottom, w: bannerView.w, h: 53)
    subBar.backgroundColor = UIColor(r: 25, g: 31, b: 40)
    
    let subBarRightButton = UIView(x: 0, y: 0, w: bannerView.w * 3 / 2, h: subBar.h)
    
    let rightImage = UIImageView(image: UIImage(named: "map.png")!)
    rightImage.frame = CGRect(x: 0, y: 0, width: 15, height: 15)
    rightImage.center = CGPoint(x: subBarRightButton.centerX, y: subBarRightButton.centerY - 5)
    rightImage.tintColor = UIColor.whiteColor()
    subBarRightButton.addSubview(rightImage)
    
    let rightLabel = UILabel(x: 0, y: rightImage.bottom, w: 0, h: 0)
    rightLabel.textColor = UIColor.whiteColor()
    rightLabel.text = "Map View"
    rightLabel.font = UIFont(name: FontName.HelveticaNeue.rawValue, size: 11)
    rightLabel.fitSize()
    rightLabel.center = CGPoint(x: rightImage.centerX, y: rightImage.centerY + 20)
    subBarRightButton.addSubview(rightLabel)
    
    subBar.addSubview(subBarRightButton)
    
    let seperatorView = UIView(x: subBar.centerX - 1, y: subBar.h / 6, w: 2, h: subBar.h * 2 / 3)
    seperatorView.backgroundColor = UIColor.whiteColor()
    seperatorView.alpha = 0.5
    subBar.addSubview(seperatorView)
    
    
    let subBarLeftButton = UIView(x: 0, y: 0, w: bannerView.w / 2, h: subBar.h)
    
    let leftImage = UIImageView(image: UIImage(named: "burger.png")!)
    leftImage.frame = CGRect(x: 0, y: 0, width: 15, height: 15)
    leftImage.center = CGPoint(x: subBarLeftButton.centerX, y: subBarLeftButton.centerY - 5)
    leftImage.tintColor = UIColor.whiteColor()
    subBarLeftButton.addSubview(leftImage)
    
    let leftLabel = UILabel(x: 0, y: leftImage.bottom, w: 0, h: 0)
    leftLabel.textColor = UIColor.whiteColor()
    leftLabel.text = "List View"
    leftLabel.font = UIFont(name: FontName.HelveticaNeue.rawValue, size: 11)
    leftLabel.fitSize()
    leftLabel.center = CGPoint(x: leftImage.centerX, y: leftImage.centerY + 20)
    subBarLeftButton.addSubview(leftLabel)
    
    subBar.addSubview(subBarLeftButton)
    
    bannerView.addSubview(subBar)
    
    // At first these should be deselected
    leftImage.alpha = 0.5
    leftLabel.alpha = 0.5
    
    subBarLeftButton.addTapGesture { (gesture) -> () in
      // Go to list view
      self.mapView.hidden = true
      self.activityTableView.hidden = false
      leftImage.alpha = 1
      leftLabel.alpha = 1
      rightImage.alpha = 0.5
      rightLabel.alpha = 0.5
      
    }
    
    subBarRightButton.addTapGesture { (gesture) -> () in
      // Go to map view
      self.mapView.hidden = false
      self.activityTableView.hidden = true
      leftImage.alpha = 0.5
      leftLabel.alpha = 0.5
      rightImage.alpha = 1
      rightLabel.alpha = 1
    }
    
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
      newActivity.description = activity["descriptionLong"]as! String
      newActivity.distanceFromHotel = activity["distanceFromHotel"]as! Float
      newActivity.match = activity["match"]as! Float
      newActivity.price = activity["price"]as! String
      newActivity.rating = activity["rating"]as! Float
      newActivity.ratingName = activity["ratingName"]as! String
      newActivity.ratingDescription = activity["ratingDescription"]as! String
      guard let image = activity["img"] else
      {
        break
      }
      newActivity.image = image as! String
      activityList.append(newActivity)
    }
  }
}