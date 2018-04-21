//
//  HelpViewController.swift
//  Ratios
//
//  Created by James Pamplona on 1/27/18.
//  Copyright © 2018 James Pamplona. All rights reserved.
//

import UIKit
import GoogleMobileAds

class HelpViewController: UIViewController, StoryboardInitializable, GADBannerViewDelegate {
    
    
    @IBOutlet weak var helpBanner: GADBannerView!
    
    override func viewDidLoad() {
        super.viewDidLoad()

        // Do any additional setup after loading the view.
        
        //Admob
        //MARK:= google Adwords
        // Test AdMob Banner ID
        //helpBanner.adUnitID = "ca-app-pub-3940256099942544/2934735716"
        
        // Live AdMob Banner ID
        helpBanner.adUnitID = "ca-app-pub-3940256099942544/6300978111"
        helpBanner.rootViewController = self
        helpBanner.load(GADRequest())
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    

    
    @IBAction func closeTapped() {
        dismiss(animated: true)
    }
    /*
    // MARK: - Navigation

    // In a storyboard-based application, you will often want to do a little preparation before navigation
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        // Get the new view controller using segue.destinationViewController.
        // Pass the selected object to the new view controller.
    }
    */

}
