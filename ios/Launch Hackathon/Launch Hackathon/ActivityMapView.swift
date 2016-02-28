//
//  ActivityMapView.swift
//  Launch Hackathon
//
//  Created by Furkan Yilmaz on 27/02/16.
//  Copyright © 2016 Lucas Farah. All rights reserved.
//

import UIKit
import ArcGIS

class ActivityMapView: UIView {
    
    var mapView: AGSMapView!
    var graphicLayer:AGSGraphicsLayer!
    var locator:AGSLocator!
    var calloutTemplate:AGSCalloutTemplate!
    
    var selectedGraphic: AGSGraphic!
    
    let kGeoLocatorURL = "http://geocode.arcgis.com/arcgis/rest/services/World/GeocodeServer"
    
    var activityList: [Activity] = []
    
    init(frame: CGRect, data activities : [Activity]) {
        super.init(frame: frame)
        activityList = activities
        
        self.backgroundColor = UIColor.grayColor()
        self.createMap()
        
        startGeocoding()
    }
    
    required init(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    func createMap() {
        mapView = AGSMapView(x: 0, y: 0, w: frame.width, h: frame.height)
        self.mapView.layerDelegate = self
        self.mapView.callout.delegate = self
        
        let url = NSURL(string: "http://server.arcgisonline.com/ArcGIS/rest/services/World_Street_Map/MapServer")
        let tiledLayer = AGSTiledMapServiceLayer(URL: url)
        mapView.addMapLayer(tiledLayer, withName: "Basemap Tiled Layer")
        
        self.graphicLayer = AGSGraphicsLayer()
        self.mapView.addMapLayer(self.graphicLayer, withName:"Results")
        
        addSubview(mapView)
    }
    
    func createPins(newPoint: AGSPoint, activityName: String, activityLocation: String) -> AGSGeometry {
        //Add a graphics layer to the map. This layer will hold geocoding results
        
        //Assign a simple renderer to the layer to display results as pushpins
        let pushpin = AGSPictureMarkerSymbol(imageNamed: "BluePushpin.png")
        pushpin.offset = CGPointMake(9, 16)
        pushpin.leaderPoint = CGPointMake(-9, 11)
        
        let geometryEngine = AGSGeometryEngine()
        
        //            let renderer = AGSSimpleRenderer(symbol: pushpin)
        //            self.graphicLayer.renderer = renderer
        
        //        let newPoint = AGSPoint(x: -122.4194155,y: 37.7749295, spatialReference: AGSSpatialReference.wgs84SpatialReference())
        
        let reprojectedPoint = geometryEngine.projectGeometry(newPoint, toSpatialReference: AGSSpatialReference.webMercatorSpatialReference())
        let graphic = AGSGraphic(geometry: reprojectedPoint, symbol: pushpin, attributes: ["name": activityName, "location": activityLocation])
        graphicLayer.addGraphic(graphic)
        
        mapView.zoomToScale(500000, withCenterPoint: reprojectedPoint as! AGSPoint, animated: true)
        return reprojectedPoint
    }
    
    func startGeocoding() {
        self.mapView.callout.hidden = true
        
        // clear out previous results
//        self.graphicLayer.removeAllGraphics()
        
        self.locator = AGSLocator(URL: NSURL(string: kGeoLocatorURL))
        self.locator.delegate = self
        
        for activity in activityList {
            let parameters = AGSLocatorFindParameters()
            parameters.text = activity.address
            parameters.outSpatialReference = self.mapView.spatialReference
            parameters.outFields = ["*"]
            self.locator.findWithParameters(parameters)
        }
        
    }
}

extension ActivityMapView: AGSMapViewLayerDelegate {
    func mapViewDidLoad(mapView: AGSMapView!) {
        //        mapView.locationDisplay.startDataSource()
    }
}

extension ActivityMapView: AGSCalloutDelegate {
    
    func callout(callout: AGSCallout!, willShowForFeature feature: AGSFeature!, layer: AGSLayer!, mapPoint: AGSPoint!) -> Bool {
        let graphic = feature as! AGSGraphic
        
        self.mapView.callout.title = graphic.attributeAsStringForKey("name")
        self.mapView.callout.detail = graphic.attributeAsStringForKey("location")
        return true
    }
    
    func didClickAccessoryButtonForCallout(callout: AGSCallout!) {
        
        self.selectedGraphic = callout.representedObject as! AGSGraphic
        
        // TODO: Open detailed view
        //        self.performSegueWithIdentifier("ResultsSegue", sender: self)
    }
}

extension ActivityMapView: AGSLocatorDelegate {
    func locator(locator: AGSLocator!, operation op: NSOperation!, didFind results: [AnyObject]!) {
        //check and see if we didn't get any results
        if results == nil || results.count == 0 {
            //show alert if we didn't get results
//            UIAlertView(title: "No Results", message: "No Results Found By Locator", delegate: nil, cancelButtonTitle: "OK").show()
        }
        else
        {
            var bestCandidate: AGSLocatorFindResult?
            var bestCandidateScore = 0
            //loop through all candidates/results and add to graphics layer
            for candidate in results as! [AGSLocatorFindResult] {
                let candidateScore = candidate.graphic.attributeForKey("Score") as! Int
                
                if bestCandidateScore <= candidateScore {
                    bestCandidateScore = candidateScore
                    bestCandidate = candidate
                    if bestCandidateScore == 100 {
                        break
                    }
                }
            }
            
            if let bestCandidate = bestCandidate {
                print(bestCandidate)
                
                let pt = bestCandidate.graphic.geometry as! AGSPoint
                
                var name = bestCandidate.graphic.attributeForKey("PlaceName") as? String
                if name == "" {
                    name = bestCandidate.name
                }
                
                var location = bestCandidate.graphic.attributeForKey("Place_addr") as? String
                if location == "" {
                    location = bestCandidate.graphic.attributeForKey("Match_addr") as? String
                }
//                let type = bestCandidate.graphic.attributeForKey("Type") as? String
                
                if let name = name {
                    if let location = location {
                        let reprojectedPoint = createPins(pt, activityName: name, activityLocation: location)
                        //we have one result, center at that point
                        mapView.zoomToScale(500000, withCenterPoint: reprojectedPoint as! AGSPoint, animated: true)
                        
                        // set the width of the callout
                        self.mapView.callout.width = 250
                        
                        //show the callout
                        self.mapView.callout.showCalloutAtPoint(bestCandidate.graphic.geometry as! AGSPoint, forFeature: bestCandidate.graphic, layer:bestCandidate.graphic.layer, animated:true)
                    }
                }
                
                
                
            } else {
                UIAlertView(title: "No Results", message: "No Results Found By Locator", delegate: nil, cancelButtonTitle: "OK").show()
            }
            //            }
            
            //if we have more than one result, zoom to the extent of all results
            //            if results.count > 1 {
            //                self.mapView.zoomToEnvelope(self.graphicLayer.fullEnvelope, animated:true)
            //            }
        }
        
    }
    
    func locator(locator: AGSLocator!, operation op: NSOperation!, didFailToFindWithError error: NSError!) {
        //The location operation failed, display the error
        UIAlertView(title: "Locator failed", message: error.localizedDescription, delegate: nil, cancelButtonTitle: "OK").show()
    }
    
    
}
