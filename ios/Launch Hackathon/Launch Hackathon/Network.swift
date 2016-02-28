//
//  Network.swift
//  Launch Hackathon
//
//  Created by Furkan Yilmaz on 27/02/16.
//  Copyright © 2016 Lucas Farah. All rights reserved.
//

import Foundation

struct Network {
    
    static var baseMapURL = "http://server.arcgisonline.com/ArcGIS/rest/services/World_Street_Map/MapServer"
    
    static func getJSONData() -> [[String:AnyObject]] {
        let path = NSBundle.mainBundle().pathForResource("activities", ofType: "json")
        let jsonData = NSData(contentsOfFile: path!)
        do
        {
          let jsonArray = try NSJSONSerialization.JSONObjectWithData(jsonData!, options: .MutableContainers) as! [String:AnyObject]
            
            return jsonArray["activities"] as!  [[String:AnyObject]]
        }
        catch{}
        
        return [[String:AnyObject]]()
    }
}
