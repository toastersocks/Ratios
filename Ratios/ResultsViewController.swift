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
    
    @IBOutlet weak var forMessageLabel: UILabel! {
        didSet {
            setForMessageLabel()
        }
    }
    private func setForMessageLabel() {
        forMessageLabel?.text = state.forMessage
        forMessageLabel?.accessibilityLabel = state.accessibleForMessage
    }
    @IBOutlet weak var mixMessageLabel: UILabel! {
        didSet {
            setMixMessageLabel()
        }
    }
    private func setMixMessageLabel() {
        mixMessageLabel?.text = state.mixMessage
        mixMessageLabel?.accessibilityLabel = state.accessibleMixMessage
    }
    
    var state = State(forMessage: "", mixMessage: "") {
        didSet {
            setForMessageLabel()
            setMixMessageLabel()
        }
    }
    
    weak var delegate: ResultsViewDelegate?
    
    struct State {
        var forMessage: String
        var accessibleForMessage: String? = nil
        var mixMessage: String
        var accessibleMixMessage: String? = nil
        
        init(forMessage: String, mixMessage: String, accessibleMixMessage: String? = nil, accessibleForMessage: String? = nil) {
            self.forMessage = forMessage
            self.mixMessage = mixMessage
            self.accessibleForMessage = accessibleForMessage
            self.accessibleMixMessage = accessibleMixMessage
        }
    }
        
    override func viewDidLoad() {
        super.viewDidLoad()
        //Admob
        //MARK:= google Adwords
        #if RELEASE
        // Live AdMob Banner ID
        resultsBanner.adUnitID = "ca-app-pub-3940256099942544/6300978111"
        #else
        // Test AdMob Banner ID
        resultsBanner.adUnitID = "ca-app-pub-3940256099942544/2934735716"
        #endif
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
