//
//  BookingViewController.swift
//  Launch Hackathon
//
//  Created by Lucas Farah on 2/28/16.
//  Copyright © 2016 Lucas Farah. All rights reserved.
//

import UIKit

class BookingViewController: UIViewController {
  
  @IBOutlet weak var lblActivitiesPrice: UILabel!
  @IBOutlet weak var lblIncludingActivity: UILabel!
  @IBOutlet weak var lblPlanePrice: UILabel!
  @IBOutlet weak var lblHotel: UILabel!
  @IBOutlet weak var lblAirlines: UILabel!
  override func viewDidLoad() {
    super.viewDidLoad()
    
    // Do any additional setup after loading the view.
    let dic = self.getJSONData()
    guard let hotel = dic["hotel"] else
    {
      return
    }
    if let name = hotel["Name"]
    {
      self.lblHotel.text = "\(name as! String)"
    }
    guard let flight = dic["flight"]!["FlightPriceSummary"] else
    {
      return
    }
    if let price = flight!["TotalPrice"]
    {
      self.lblPlanePrice.text = "$\(Int(price as! Double))"
    }
    guard let activities = dic["activities"] else
 {
      return
    }
    
    var totalPrice = 0.0
    for activity in activities as! [[String:AnyObject]]
    {
      let activityPriceString = activity["price"] as! String
      let cutPriceString = activityPriceString[1...activityPriceString.length-1]
      let priceDouble = cutPriceString.toDouble()
      totalPrice += priceDouble!
    }
    let act = activities
      as! [[String:AnyObject]]
    let actFirst = act.last
    let nameActFirst = actFirst!["name"] as! String
    self.lblIncludingActivity.text = "Including \(nameActFirst)"
    self.lblActivitiesPrice.text = "$\(Int(totalPrice))"
  }
  func getJSONData() -> [String:AnyObject]
  {
    let path = NSBundle.mainBundle().pathForResource("activities", ofType: "json")
    let jsonData = NSData(contentsOfFile: path!)
    do
    {
      let jsonArray = try NSJSONSerialization.JSONObjectWithData(jsonData!, options: .MutableContainers) as! [String:AnyObject]
      
      return jsonArray as!  [String:AnyObject]
    }
    catch{}
    
    return [String:AnyObject]()
  }
  override func didReceiveMemoryWarning() {
    super.didReceiveMemoryWarning()
    // Dispose of any resources that can be recreated.
  }
  
  
  /*
  // MARK: - Navigation
  
  // In a storyboard-based application, you will often want to do a little preparation before navigation
  override func prepareForSegue(segue: UIStoryboardSegue, sender: AnyObject?) {
  // Get the new view controller using segue.destinationViewController.
  // Pass the selected object to the new view controller.
  }
  */
  
}
