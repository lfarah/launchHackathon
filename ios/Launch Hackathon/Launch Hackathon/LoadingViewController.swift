//
//  LoadingViewController.swift
//  Launch Hackathon
//
//  Created by Lucas Farah on 2/27/16.
//  Copyright © 2016 Lucas Farah. All rights reserved.
//

import UIKit

class LoadingViewController: UIViewController {
  
  @IBOutlet weak var slider: UISlider!
  @IBOutlet weak var slider2: UISlider!
  @IBOutlet weak var slider3: UISlider!
  @IBOutlet weak var slider4: UISlider!
  
  let arrCities = ["San Francisco","New York","Los Angeles","Manaus","London"]
  let arrValues = ["0.0","0.7","0.4","0.9","0.7","1","0.8","0.1"]
  let arrValues2 = ["0.9","0.9","0.1","0.9","0.2","1","0.5","0.9"]
  let arrValues3 = ["0.5","0.4","0.4","0.9","0.3","0.3","0.4","0.4"]
  let arrValues4 = ["0.8","0.1","0.6","0.9","0.5","0.1","0.2","0.7"]
  
  @IBOutlet weak var spotLoadView: STSpotLoadView!
  
  @IBOutlet weak var lblCity: UILabel!
  override func viewDidLoad() {
    super.viewDidLoad()
    
    // Do any additional setup after loading the view.
    spotLoadView.startAnimation()
    var count = 0
    ez.runThisEvery(seconds: 2) { (timer) -> Void in
      UIView.animateWithDuration(1.0, delay: 0.0, options: UIViewAnimationOptions.CurveEaseOut, animations: {
        self.lblCity.alpha = 0.0
        }, completion: {
          (finished: Bool) -> Void in
          
          //Once the label is completely invisible, set the text and fade it back in
          if count < self.arrCities.count
          {
            self.lblCity.text = self.arrCities[count]
          }
          else
          {
            self.performSegueWithIdentifier("next", sender: self)
          }
          // Fade in
          UIView.animateWithDuration(0.7, delay: 0.0, options: UIViewAnimationOptions.CurveEaseIn, animations: {
            self.lblCity.alpha = 1.0
            }, completion: nil)
      })
      UIView.animateWithDuration(0.7, animations: { () -> Void in
        self.slider.setValue(self.slider.value, animated: true)
        
        }) { (bol) -> Void in
          UIView.animateWithDuration(0.7, animations: { () -> Void in
            if count < self.arrValues.count
            {
              self.slider.setValue(self.arrValues[count].toFloat()!, animated: true)
            }
            }, completion: nil)
      }
      UIView.animateWithDuration(0.7, animations: { () -> Void in
        self.slider2.setValue(self.slider2.value, animated: true)
        
        }) { (bol) -> Void in
          UIView.animateWithDuration(0.7, animations: { () -> Void in
            if count < self.arrValues2.count
            {
              self.slider2.setValue(self.arrValues2[count].toFloat()!, animated: true)
            }
            }, completion: nil)
      }
      UIView.animateWithDuration(0.7, animations: { () -> Void in
        self.slider3.setValue(self.slider3.value, animated: true)
        
        }) { (bol) -> Void in
          UIView.animateWithDuration(0.7, animations: { () -> Void in
            if count < self.arrValues3.count
            {
              self.slider3.setValue(self.arrValues3[count].toFloat()!, animated: true)
            }
            }, completion: nil)
      }
      UIView.animateWithDuration(0.7, animations: { () -> Void in
        self.slider4.setValue(self.slider4.value, animated: true)
        
        }) { (bol) -> Void in
          UIView.animateWithDuration(0.7, animations: { () -> Void in
            if count < self.arrValues4.count
            {
              self.slider4.setValue(self.arrValues4[count].toFloat()!, animated: true)
            }
            }, completion: nil)
      }
      count++
    }
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
