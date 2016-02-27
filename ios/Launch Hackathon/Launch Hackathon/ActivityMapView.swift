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
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        
        createMap()
        createPins()
    }

    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    func createMap() {
        mapView = AGSMapView(x: 0, y: 0, w: frame.width, h: frame.height)
        self.mapView.layerDelegate = self
        
        let url = NSURL(string: "http://server.arcgisonline.com/ArcGIS/rest/services/World_Street_Map/MapServer")
        let tiledLayer = AGSTiledMapServiceLayer(URL: url)
        mapView.addMapLayer(tiledLayer, withName: "Basemap Tiled Layer")
        
        //    mapView.toMapPoint(CGPoint(x: 37.7749295, y: -122.41941550000001))
//        mapView.zoomToResolution(10000, animated: false)
        addSubview(mapView)
    }
    
    func createPins() {
        if self.graphicLayer == nil {
            //Add a graphics layer to the map. This layer will hold geocoding results
            self.graphicLayer = AGSGraphicsLayer()
            self.mapView.addMapLayer(self.graphicLayer, withName:"Results")
            //Assign a simple renderer to the layer to display results as pushpins
            let pushpin = AGSPictureMarkerSymbol(imageNamed: "BluePushpin.png")
            pushpin.offset = CGPointMake(9, 16)
            pushpin.leaderPoint = CGPointMake(-9, 11)
//            let renderer = AGSSimpleRenderer(symbol: pushpin)
//            self.graphicLayer.renderer = renderer
            
            let newPoint = AGSPoint(x: -122.4194155,y: 37.7749295, spatialReference: AGSSpatialReference.wgs84SpatialReference())
            let graphic = AGSGraphic(geometry: newPoint, symbol: pushpin, attributes: nil)
            graphicLayer.addGraphic(graphic)
        }
        else {
            //Clear out previous results if we already have a graphics layer
            self.graphicLayer.removeAllGraphics()
        }
        
//        if self.locator == nil {
//            //Create the AGSLocator pointing to the geocode service on ArcGIS Online
//            //Set the delegate so that we are informed through AGSLocatorDelegate methods
//            let url = NSURL(string: "http://geocode.arcgis.com/arcgis/rest/services/World/GeocodeServer")
//            self.locator = AGSLocator(URL: url)
//            self.locator.delegate = self
//        }


        

//        mapView.centerAtPoint(newPoint, animated: false)
        
        //Set the parameters
//        let params = AGSLocatorFindParameters()
//        params.text = "popo"
//        params.outFields = ["*"]
//        params.outSpatialReference = self.mapView.spatialReference
//        params.location = AGSPoint(x: 24, y: -122, spatialReference: mapView.spatialReference)
//        
//        //Kick off the geocoding operation
//        //This will invoke the geocode service on a background thread
//        self.locator.findWithParameters(params)
    }
}

extension ActivityMapView: AGSMapViewLayerDelegate {
    func mapViewDidLoad(mapView: AGSMapView!) {
//        mapView.locationDisplay.startDataSource()
    }
}
//
//extension ActivityMapView: AGSLocatorDelegate {
//    func locator(locator: AGSLocator!, operation op: NSOperation!, didFind results: [AnyObject]!) {
//        if results == nil || results.count == 0 {
//            //show alert if we didn't get results
//        }
//        else {
//            //Create a callout template if we haven't done so already
//            if self.calloutTemplate == nil {
//                self.calloutTemplate = AGSCalloutTemplate()
//                self.calloutTemplate.titleTemplate = "${Match_addr}"
//                self.calloutTemplate.detailTemplate = "${DisplayY}\u{00b0} ${DisplayX}\u{00b0}"
//                
//                //Assign the callout template to the layer so that all graphics within this layer
//                //display their information in the callout in the same manner
//                self.graphicLayer.calloutDelegate = self.calloutTemplate
//            }
//            
//            //Add a graphic for each result
//            for result in results as! [AGSLocatorFindResult] {
//                //                print(result.name)
////                cityData.append(result.name)
//                self.graphicLayer.addGraphic(result.graphic)
//            }
//            
//            //Zoom in to the results
//            let extent = self.graphicLayer.fullEnvelope.mutableCopy() as! AGSMutableEnvelope
//            extent.expandByFactor(1.5)
//            self.mapView.zoomToEnvelope(extent, animated: true)
//        }
//    }
//    
//    func locator(locator: AGSLocator!, operation op: NSOperation!, didFailLocationsForAddress error: NSError!) {
//        //        UIAlertView(title: "Locator Failed", message: error.localizedDescription, delegate: nil, cancelButtonTitle: "OK").show()
//    }
//}
