//
//  StrainsViewController.swift
//  Ratios
//
//  Created by James Pamplona on 1/27/18.
//  Copyright © 2018 James Pamplona. All rights reserved.
//

import UIKit
import GoogleMobileAds

class StrainsViewController: DismissKeyboardViewController, StoryboardInitializable, GADBannerViewDelegate {
    
    
    @IBOutlet weak var strainsBanner: GADBannerView!
    
    @IBOutlet weak var thcStrainTHCPercentageField: UITextField!
    @IBOutlet weak var thcStrainCBDPercentageField: UITextField!
    @IBOutlet weak var cbdStrainTHCPercentageField: UITextField!
    @IBOutlet weak var cbdStrainCBDPercentageField: UITextField!
    @IBOutlet weak var nextButton: UIButton! {
        didSet {
            nextButton.setBackgroundColor(nextButton.tintColor, for: .normal)
            nextButton.setBackgroundColor(nextButton.tintColor?.withAlphaComponent(0.25), for: .disabled)
            nextButton.isEnabled = shouldNextButtonBeEnabled()
        }
    }
    
    var state = State(thcStrainTHCPercentage: "", thcStrainCBDPercentage: "", cbdStrainTHCPercentage: "", cbdStrainCBDPercentage: "") {
        didSet {
            thcStrainTHCPercentageField?.text = state.thcStrainTHCPercentage
            thcStrainCBDPercentageField?.text = state.thcStrainCBDPercentage
            cbdStrainTHCPercentageField?.text = state.cbdStrainTHCPercentage
            cbdStrainCBDPercentageField?.text = state.cbdStrainCBDPercentage
        }
    }
    
    weak var delegate: StrainsViewDelegate?
    weak var textFieldDelegate: DecimalNumberValidator?
    
    struct State {
        var thcStrainTHCPercentage: String = ""
        var thcStrainCBDPercentage: String = ""
        var cbdStrainTHCPercentage: String = ""
        var cbdStrainCBDPercentage: String = ""
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        thcStrainTHCPercentageField.delegate = textFieldDelegate
        thcStrainCBDPercentageField.delegate = textFieldDelegate
        cbdStrainTHCPercentageField.delegate = textFieldDelegate
        cbdStrainCBDPercentageField.delegate = textFieldDelegate
        // Do any additional setup after loading the view.
        
        //Admob
        //MARK:= google Adwords
        // Test AdMob Banner ID
        strainsBanner.adUnitID = "ca-app-pub-3940256099942544/2934735716"
        
        // Live AdMob Banner ID
        //strainsBanner.adUnitID = "ca-app-pub-3940256099942544/6300978111"
        strainsBanner.rootViewController = self
        strainsBanner.load(GADRequest())
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
    @IBAction func nextTapped() {
        delegate?.nextTapped(with: state)
    }
    
    private func shouldNextButtonBeEnabled() -> Bool {
        return (!state.thcStrainTHCPercentage.isEmpty &&
                !state.thcStrainCBDPercentage.isEmpty &&
                !state.cbdStrainTHCPercentage.isEmpty &&
                !state.cbdStrainCBDPercentage.isEmpty)
    }

    @IBAction func textChanged(_ sender: Any) {
        
        state = State(
            thcStrainTHCPercentage: thcStrainTHCPercentageField.text ?? "",
            thcStrainCBDPercentage: thcStrainCBDPercentageField.text ?? "",
            cbdStrainTHCPercentage: cbdStrainTHCPercentageField.text ?? "",
            cbdStrainCBDPercentage: cbdStrainCBDPercentageField.text ?? "")
        
        nextButton.isEnabled = shouldNextButtonBeEnabled()
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
