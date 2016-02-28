//
//  MainTableViewController.swift
//
// Copyright (c) 21/12/15. Ramotion Inc. (http://ramotion.com)
//
// Permission is hereby granted, free of charge, to any person obtaining a copy
// of this software and associated documentation files (the "Software"), to deal
// in the Software without restriction, including without limitation the rights
// to use, copy, modify, merge, publish, distribute, sublicense, and/or sell
// copies of the Software, and to permit persons to whom the Software is
// furnished to do so, subject to the following conditions:
//
// The above copyright notice and this permission notice shall be included in
// all copies or substantial portions of the Software.
//
// THE SOFTWARE IS PROVIDED "AS IS", WITHOUT WARRANTY OF ANY KIND, EXPRESS OR
// IMPLIED, INCLUDING BUT NOT LIMITED TO THE WARRANTIES OF MERCHANTABILITY,
// FITNESS FOR A PARTICULAR PURPOSE AND NONINFRINGEMENT. IN NO EVENT SHALL THE
// AUTHORS OR COPYRIGHT HOLDERS BE LIABLE FOR ANY CLAIM, DAMAGES OR OTHER
// LIABILITY, WHETHER IN AN ACTION OF CONTRACT, TORT OR OTHERWISE, ARISING FROM,
// OUT OF OR IN CONNECTION WITH THE SOFTWARE OR THE USE OR OTHER DEALINGS IN
// THE SOFTWARE.

import UIKit


class MainTableViewController: UITableViewController {
  
  let kCloseCellHeight: CGFloat = 179
  let kOpenCellHeight: CGFloat = 488
  
  let kRowsCount = 10
  
  var cellHeights = [CGFloat]()
  
  //Array
  var activities = [[String:AnyObject]]()
  override func viewDidLoad() {
    super.viewDidLoad()
    
    createCellHeightsArray()
    //        self.tableView.backgroundColor = UIColor(patternImage: UIImage(named: "blank timeline with line.png")!)
    self.tableView.backgroundColor = .clearColor()
    //      self.setBackgroundImage("blank timeline with line.png")
    
    activities = Network.getJSONData()
    self.tableView.reloadData()
  }
  
  // MARK: configure
  func createCellHeightsArray() {
    for _ in 0...kRowsCount {
      cellHeights.append(kCloseCellHeight)
    }
  }
  
  // MARK: - Table view data source
  
  override func tableView(tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
    return activities.count
  }
  
  override func tableView(tableView: UITableView, willDisplayCell cell: UITableViewCell, forRowAtIndexPath indexPath: NSIndexPath) {
    
    if cell is FoldingCell {
      let foldingCell = cell as! FoldingCell
      foldingCell.backgroundColor = UIColor.clearColor()
      
      if cellHeights[indexPath.row] == kCloseCellHeight {
        foldingCell.selectedAnimation(false, animated: false, completion:nil)
      } else {
        foldingCell.selectedAnimation(true, animated: false, completion: nil)
      }
    }
  }
  
  override func tableView(tableView: UITableView, cellForRowAtIndexPath indexPath: NSIndexPath) -> UITableViewCell {
    let cell = tableView.dequeueReusableCellWithIdentifier("FoldingCell", forIndexPath: indexPath) as! DemoCell
    cell.lblNameActivity.text = activities[indexPath.row]["name"] as? String
    let dicActivity = activities[indexPath.row]
    guard let name = dicActivity["name"] else
    {
      return cell
    }
    guard let price = dicActivity["price"] else
    {
      return cell
    }
    guard let distanceFromHotel = dicActivity["distanceFromHotel"] else
    {
      return cell
    }
    guard let address = dicActivity["address"] else
    {
      return cell
    }
    cell.lblPriceActivity.text = "$\(price)"
    cell.lblNameActivity.text = "\(name)"
    cell.lblDistanceActivity.text = "\(distanceFromHotel) mi."
    cell.lblAddressActivity.text = "\(address)"
    return cell
  }
  
  override func tableView(tableView: UITableView, heightForRowAtIndexPath indexPath: NSIndexPath) -> CGFloat {
    return cellHeights[indexPath.row]
  }
  
  // MARK: Table vie delegate
  
  override func tableView(tableView: UITableView, didSelectRowAtIndexPath indexPath: NSIndexPath) {
    
    let cell = tableView.cellForRowAtIndexPath(indexPath) as! FoldingCell
    
    if cell.isAnimating() {
      return
    }
    
    var duration = 0.0
    if cellHeights[indexPath.row] == kCloseCellHeight { // open cell
      cellHeights[indexPath.row] = kOpenCellHeight
      cell.selectedAnimation(true, animated: true, completion: nil)
      duration = 0.5
    } else {// close cell
      cellHeights[indexPath.row] = kCloseCellHeight
      cell.selectedAnimation(false, animated: true, completion: nil)
      duration = 0.8
    }
    
    UIView.animateWithDuration(duration, delay: 0, options: .CurveEaseOut, animations: { () -> Void in
      tableView.beginUpdates()
      tableView.endUpdates()
      }, completion: nil)
    
    
  }  
}
