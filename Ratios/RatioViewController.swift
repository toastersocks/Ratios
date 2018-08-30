//
//  RatioViewController.swift
//  Ratios
//
//  Created by James Pamplona on 1/27/18.
//  Copyright © 2018 James Pamplona. All rights reserved.
//

import UIKit
import GoogleMobileAds

class RatioViewController: DismissKeyboardViewController, StoryboardInitializable, GADBannerViewDelegate {

    @IBOutlet weak var ratioBanner: GADBannerView!
    @IBOutlet weak var substanceXLabel: UITextField!
    @IBOutlet weak var substanceYLabel: UITextField!
    @IBOutlet weak var desiredXRatioField: UITextField!
    @IBOutlet weak var desiredYRatioField: UITextField!
    @IBOutlet weak var gramsField: UITextField!
    @IBOutlet weak var nextButton: UIButton! {
        didSet {
            nextButton.setBackgroundColor(nextButton.tintColor, for: .normal)
            nextButton.setBackgroundColor(nextButton.tintColor?.withAlphaComponent(0.25), for: .disabled)
            nextButton.isEnabled = shouldNextButtonBeEnabled()
        }
    }
    
    var state = State() {
        didSet {
            desiredXRatioField?.text = state.xRatio
            desiredYRatioField?.text = state.yRatio
            substanceXLabel?.text = state.xLabel
            substanceYLabel?.text = state.yLabel
            gramsField?.text = state.grams
        }
    }
    
    weak var delegate: RatioViewDelegate?
    weak var textFieldDelegate: DecimalNumberValidator?
    
    struct State {
        var xRatio: String = ""
        var yRatio: String = ""
        var xLabel: String = "A"
        var yLabel: String = "B"
        
        var grams: String?
        
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        desiredXRatioField.delegate = textFieldDelegate
        desiredYRatioField.delegate = textFieldDelegate
        gramsField.delegate = textFieldDelegate
        
        //Admob
        //MARK:= google Adwords
        #if RELEASE
        // Live AdMob Banner ID
        ratioBanner.adUnitID = "ca-app-pub-3940256099942544/6300978111"
        #else
        // Test AdMob Banner ID
        ratioBanner.adUnitID = "ca-app-pub-3940256099942544/2934735716"
        #endif
        ratioBanner.rootViewController = self
        ratioBanner.load(GADRequest())

    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
    @IBAction func nextTapped() {
        delegate?.nextTapped(with: state)
    }
    
    private func shouldNextButtonBeEnabled() -> Bool {
        return !state.xRatio.isEmpty && !state.yRatio.isEmpty
    }
    
    /*
    // MARK: - Navigation

    // In a storyboard-based application, you will often want to do a little preparation before navigation
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        // Get the new view controller using segue.destinationViewController.
        // Pass the selected object to the new view controller.
    }
    */

    @IBAction func textFieldChanged(_ sender: UITextField) {
        
        state = State(
            xRatio: desiredXRatioField.text ?? "",
            yRatio: desiredYRatioField.text ?? "",
            xLabel: substanceXLabel.text ?? "A",
            yLabel: substanceYLabel.text ?? "B",
            grams: gramsField.text)
        
        nextButton.isEnabled = shouldNextButtonBeEnabled()
    }
}
