//
//  CitiesViewController.swift
//  Launch Hackathon
//
//  Created by Lucas Farah on 2/27/16.
//  Copyright © 2016 Lucas Farah. All rights reserved.
//

import UIKit

class CitiesViewController: UIViewController {
  
  override func viewDidLoad() {
    super.viewDidLoad()
    
    // Do any additional setup after loading the view.
    if let dicFirst = readAlgorithm().first
    {
      guard let name = dicFirst["name"] else
      {
        return
      }
      guard let score = dicFirst["score"] else
      {
        return
      }
      print("\(name) - \(score)")
    }
  }
  
  func readAlgorithm() -> [[String:AnyObject]]
  {
    let path = NSBundle.mainBundle().pathForResource("match", ofType: "json")
    let jsonData = NSData(contentsOfFile: path!)
    do
    {
      let jsonArray = try NSJSONSerialization.JSONObjectWithData(jsonData!, options: .MutableContainers) as! [AnyObject]
      
      return jsonArray as!  [[String:AnyObject]]
    }
    catch{}
    
    return [[String:AnyObject]]()
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
