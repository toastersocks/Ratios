//
//  ResultsViewController.swift
//  Ratios
//
//  Created by James Pamplona on 1/27/18.
//  Copyright © 2018 James Pamplona. All rights reserved.
//

import UIKit
import GoogleMobileAds

class ResultsViewController: UIViewController, StoryboardInitializable, GADBannerViewDelegate {
    
    
    
    @IBOutlet weak var resultsBanner: GADBannerView!
    
    @IBOutlet weak var forMessageLabel: UILabel!
    @IBOutlet weak var mixMessageLabel: UILabel!
    
    var state = State(forMessage: "", mixMessage: "") {
        didSet {
            forMessageLabel?.text = state.forMessage
            mixMessageLabel?.text = state.mixMessage
        }
    }
    
    weak var delegate: ResultsViewDelegate?
    
    struct State {
        var forMessage: String
        var mixMessage: String
    }
        
    override func viewDidLoad() {
        super.viewDidLoad()
        forMessageLabel?.text = state.forMessage
        mixMessageLabel?.text = state.mixMessage
        
        //Admob
        //MARK:= google Adwords
        // Test AdMob Banner ID
        resultsBanner.adUnitID = "ca-app-pub-3940256099942544/2934735716"
        
        // Live AdMob Banner ID
        //resultsBanner.adUnitID = "ca-app-pub-3940256099942544/6300978111"
        resultsBanner.rootViewController = self
        resultsBanner.load(GADRequest())
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
    @IBAction func newRatioTapped() {
        delegate?.newRatioTapped(with: state)
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
