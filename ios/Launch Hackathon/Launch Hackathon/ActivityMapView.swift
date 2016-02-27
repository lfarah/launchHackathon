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
//    var locator:AGSLocator!
    var calloutTemplate:AGSCalloutTemplate!
    
    var selectedGraphic: AGSGraphic!

    
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
        self.mapView.callout.delegate = self
        
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
            
            let geometryEngine = AGSGeometryEngine()

//            let renderer = AGSSimpleRenderer(symbol: pushpin)
//            self.graphicLayer.renderer = renderer
            
            let newPoint = AGSPoint(x: -122.4194155,y: 37.7749295, spatialReference: AGSSpatialReference.wgs84SpatialReference())
            let reprojectedPoint = geometryEngine.projectGeometry(newPoint, toSpatialReference: AGSSpatialReference.webMercatorSpatialReference())
            let graphic = AGSGraphic(geometry: reprojectedPoint, symbol: pushpin, attributes: nil)
            graphicLayer.addGraphic(graphic)
            
            self.calloutTemplate = AGSCalloutTemplate()
            self.calloutTemplate.titleTemplate = "FurkWorld"
            self.calloutTemplate.detailTemplate = "San Francisco"
            self.graphicLayer.calloutDelegate = self.calloutTemplate
            self.mapView.zoomToGeometry(newPoint, withPadding: 5, animated: false)
        }
        else {
            //Clear out previous results if we already have a graphics layer
            self.graphicLayer.removeAllGraphics()
        }
    }
}

extension ActivityMapView: AGSMapViewLayerDelegate {
    func mapViewDidLoad(mapView: AGSMapView!) {
//        mapView.locationDisplay.startDataSource()
    }
}

extension ActivityMapView: AGSCalloutDelegate {
    func didClickAccessoryButtonForCallout(callout: AGSCallout!) {
        
        self.selectedGraphic = callout.representedObject as! AGSGraphic
        
        // Open detailed view
//        self.performSegueWithIdentifier("ResultsSegue", sender: self)
    }
}
