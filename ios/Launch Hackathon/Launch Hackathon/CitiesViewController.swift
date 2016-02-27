//
//  CitiesViewController.swift
//  Launch Hackathon
//
//  Created by Lucas Farah on 2/27/16.
//  Copyright © 2016 Lucas Farah. All rights reserved.
//

import UIKit

class CitiesViewController: UIViewController,UITableViewDataSource,UITableViewDelegate {
  
  var arrDics = [[String:AnyObject]]()
  @IBOutlet weak var table: UITableView!
  override func viewDidLoad() {
    super.viewDidLoad()
    
    // Do any additional setup after loading the view.
    
    arrDics = readAlgorithm()
    table.reloadData()
    }
  
  func tableView(tableView: UITableView, numberOfRowsInSection section: Int) -> Int
  {
    return arrDics.count
  }
  
  func tableView(tableView: UITableView, cellForRowAtIndexPath indexPath: NSIndexPath) -> UITableViewCell
  {
    var cell = tableView.dequeueReusableCellWithIdentifier("cell") as! CitiesTableViewCell!
    if !(cell != nil)
    {
      cell = CitiesTableViewCell(style:.Default, reuseIdentifier: "cell")
    }
      let dic = arrDics[indexPath.row]
      guard let name = dic["name"] else
      {
        return cell
      }
      guard let score = dic["score"] else
      {
        return cell
      }
    print(name)
      let doubleScore = score as! Double * 100
      let percentageScore = Int(doubleScore)

    // setup cell without force unwrapping it
    cell.lblCity!.text = "\(name)\n \(percentageScore)%"
    cell.viewColor.backgroundColor = UIColor.randomColorWithAlpha(0.54)
    
    if let image = UIImage(named: name as! String)
    {
      cell.imgvCity.image = image
    }
    else
    {
      cell.imgvCity.image = UIImage(named: "San Francisco")
    }
    return cell
  }
  
  func tableView(tableView: UITableView, didSelectRowAtIndexPath indexPath: NSIndexPath)
  {
    
  }
  
  override func didReceiveMemoryWarning() {
    super.didReceiveMemoryWarning()
    // Dispose of any resources that can be recreated.
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
  
  /*
  // MARK: - Navigation
  
  // In a storyboard-based application, you will often want to do a little preparation before navigation
  override func prepareForSegue(segue: UIStoryboardSegue, sender: AnyObject?) {
  // Get the new view controller using segue.destinationViewController.
  // Pass the selected object to the new view controller.
  }
  */
  
}
