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
    @IBOutlet weak var substanceALabel: UITextField!
    @IBOutlet weak var substanceBLabel: UITextField!
    @IBOutlet weak var desiredARatioField: UITextField!
    @IBOutlet weak var desiredBRatioField: UITextField!
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
            desiredARatioField?.text = state.aRatio
            desiredBRatioField?.text = state.bRatio
            substanceALabel?.text = state.aLabel
            substanceBLabel?.text = state.bLabel
            gramsField?.text = state.grams
        }
    }
    
    weak var delegate: RatioViewDelegate?
    weak var textFieldDelegate: DecimalNumberValidator?
    
    struct State {
        var aRatio: String = ""
        var bRatio: String = ""
        var aLabel: String = "A"
        var bLabel: String = "B"
        
        var grams: String?
        
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        desiredARatioField.delegate = textFieldDelegate
        desiredBRatioField.delegate = textFieldDelegate
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
        return !state.aRatio.isEmpty && !state.bRatio.isEmpty
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
            aRatio: desiredARatioField.text ?? "",
            bRatio: desiredBRatioField.text ?? "",
            aLabel: substanceALabel.text ?? "A",
            bLabel: substanceBLabel.text ?? "B",
            grams: gramsField.text)
        
        nextButton.isEnabled = shouldNextButtonBeEnabled()
    }
}
