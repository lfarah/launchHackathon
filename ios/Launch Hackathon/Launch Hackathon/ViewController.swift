//import UIKit
//import EZSwiftExtensions
//import ArcGIS
//
//class ViewController: UIViewController {
//  
//  var containerView: UIView!
//  
//  var mapView: AGSMapView!
//  var graphicLayer:AGSGraphicsLayer!
//  var locator:AGSLocator!
//  var calloutTemplate:AGSCalloutTemplate!
//  var searchBar: UISearchBar!
//  
//  var cityData: [String] = []
//  
//  override func viewDidLoad() {
//    super.viewDidLoad()
//    
//    createView()
//  }
//  
//  override func didReceiveMemoryWarning() {
//    super.didReceiveMemoryWarning()
//    // Dispose of any resources that can be recreated.
//  }
//  
//  override func prefersStatusBarHidden() -> Bool {
//    return true
//  }
//  
//  func createView() {
//    containerView = UIView(x: 0, y: 0, w: ez.screenWidth, h: ez.screenHeight)
//    
//    createMapView()
//    createSearchBar()
//    
//    view.addSubview(containerView)
//  }
//  
//  func createMapView() {
//    mapView = AGSMapView(x: containerView.x, y: containerView.y, w: containerView.w, h: containerView.h)
//    self.mapView.layerDelegate = self
//    
//    let url = NSURL(string: "http://server.arcgisonline.com/ArcGIS/rest/services/World_Street_Map/MapServer")
//    let tiledLayer = AGSTiledMapServiceLayer(URL: url)
//    mapView.addMapLayer(tiledLayer, withName: "Basemap Tiled Layer")
//    
//    containerView.addSubview(mapView)
//    
//    //        mapView.zoomToResolution(100000, animated: false)
//    
//    //        let envelope = AGSEnvelope(xmin: -124.83145667, ymin:30.49849464, xmax:-113.91375495, ymax:44.69150688, spatialReference: mapView.spatialReference)
//    //        mapView.zoomToEnvelope(envelope, animated: false)
//    
//  }
//  
//  func createSearchBar() {
//    searchBar = UISearchBar(x: 0, y: 0, w: containerView.w, h: 50)
//    searchBar.delegate = self
//    mapView.addSubview(searchBar)
//  }
//  
//  
//}
//
//extension ViewController: AGSMapViewLayerDelegate {
//  func mapViewDidLoad(mapView: AGSMapView!) {
//    mapView.locationDisplay.startDataSource()
//  }
//}
//
//extension ViewController: AGSLocatorDelegate {
//  func locator(locator: AGSLocator!, operation op: NSOperation!, didFind results: [AnyObject]!) {
//    if results == nil || results.count == 0 {
//      //show alert if we didn't get results
//    }
//    else {
//      //Create a callout template if we haven't done so already
//      if self.calloutTemplate == nil {
//        self.calloutTemplate = AGSCalloutTemplate()
//        self.calloutTemplate.titleTemplate = "${Match_addr}"
//        self.calloutTemplate.detailTemplate = "${DisplayY}\u{00b0} ${DisplayX}\u{00b0}"
//        
//        //Assign the callout template to the layer so that all graphics within this layer
//        //display their information in the callout in the same manner
//        self.graphicLayer.calloutDelegate = self.calloutTemplate
//      }
//      
//      //Add a graphic for each result
//      for result in results as! [AGSLocatorFindResult] {
//        //                print(result.name)
//        cityData.append(result.name)
//        self.graphicLayer.addGraphic(result.graphic)
//      }
//      
//      //Zoom in to the results
//      let extent = self.graphicLayer.fullEnvelope.mutableCopy() as! AGSMutableEnvelope
//      extent.expandByFactor(1.5)
//      self.mapView.zoomToEnvelope(extent, animated: true)
//      
//      let activityVC = ActivitiesTableVC(data: cityData)
//      presentVC(activityVC)
//    }
//  }
//  
//  func locator(locator: AGSLocator!, operation op: NSOperation!, didFailLocationsForAddress error: NSError!) {
//    //        UIAlertView(title: "Locator Failed", message: error.localizedDescription, delegate: nil, cancelButtonTitle: "OK").show()
//  }
//}
//
//extension ViewController: UISearchBarDelegate {
//  func searchBarSearchButtonClicked(searchBar: UISearchBar) {
//    
//    //Hide the keyboard
//    searchBar.resignFirstResponder()
//    if self.graphicLayer == nil {
//      //Add a graphics layer to the map. This layer will hold geocoding results
//      self.graphicLayer = AGSGraphicsLayer()
//      self.mapView.addMapLayer(self.graphicLayer, withName:"Results")
//      //Assign a simple renderer to the layer to display results as pushpins
//      let pushpin = AGSPictureMarkerSymbol(imageNamed: "BluePushpin.png")
//      pushpin.offset = CGPointMake(9, 16)
//      pushpin.leaderPoint = CGPointMake(-9, 11)
//      let renderer = AGSSimpleRenderer(symbol: pushpin)
//      self.graphicLayer.renderer = renderer
//    }
//    else {
//      //Clear out previous results if we already have a graphics layer
//      self.graphicLayer.removeAllGraphics()
//    }
//    
//    if self.locator == nil {
//      //Create the AGSLocator pointing to the geocode service on ArcGIS Online
//      //Set the delegate so that we are informed through AGSLocatorDelegate methods
//      let url = NSURL(string: "http://geocode.arcgis.com/arcgis/rest/services/World/GeocodeServer")
//      self.locator = AGSLocator(URL: url)
//      self.locator.delegate = self
//    }
//    
//    //Set the parameters
//    let params = AGSLocatorFindParameters()
//    params.text = searchBar.text
//    params.outFields = ["*"]
//    params.outSpatialReference = self.mapView.spatialReference
//    params.location = AGSPoint(x: 0, y: 0, spatialReference: nil)
//    
//    //Kick off the geocoding operation
//    //This will invoke the geocode service on a background thread
//    self.locator.findWithParameters(params)
//    
//  }
//}