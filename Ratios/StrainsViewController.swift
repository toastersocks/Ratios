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
    
    @IBOutlet weak var aSubstanceTitleField: UITextField! {
        didSet {
            aSubstanceTitleField?.text = state.aSubstanceTitle
        }
    }
    @IBOutlet weak var bSubstanceTitleField: UITextField! {
        didSet {
            bSubstanceTitleField?.text = state.bSubstanceTitle
        }
    }
    @IBOutlet weak var aSubstanceXPercentageField: UITextField!
    @IBOutlet weak var aSubstanceYPercentageField: UITextField!
    @IBOutlet weak var bSubstanceXPercentageField: UITextField!
    @IBOutlet weak var bSubstanceYPercentageField: UITextField!
    @IBOutlet weak var aSubstanceXLabel: UILabel! {
        didSet {
            aSubstanceXLabel?.text = state.xPercentageName
        }
    }
    
    @IBOutlet weak var aSubstanceYLabel: UILabel! {
        didSet {
            aSubstanceYLabel?.text = state.yPercentageName
        }
    }
    
    @IBOutlet weak var bSubstanceXLabel: UILabel! {
        didSet {
            bSubstanceXLabel?.text = state.xPercentageName
        }
    }
    
    @IBOutlet weak var bSubstanceYLabel: UILabel! {
        didSet {
            bSubstanceYLabel?.text = state.yPercentageName
        }
    }
    
    @IBOutlet weak var nextButton: UIButton! {
        didSet {
            nextButton.setBackgroundColor(nextButton.tintColor, for: .normal)
            nextButton.setBackgroundColor(nextButton.tintColor?.withAlphaComponent(0.25), for: .disabled)
            nextButton.isEnabled = shouldNextButtonBeEnabled()
        }
    }
    
    var state = State() {
        didSet {
            aSubstanceXPercentageField?.text = state.aSubstanceXPercentage
            aSubstanceYPercentageField?.text = state.aSubstanceYPercentage
            bSubstanceXPercentageField?.text = state.bSubstanceXPercentage
            bSubstanceYPercentageField?.text = state.bSubstanceYPercentage
            
            aSubstanceTitleField?.text = state.aSubstanceTitle
            bSubstanceTitleField?.text = state.bSubstanceTitle
            
            aSubstanceXLabel?.text = state.xPercentageName
            aSubstanceYLabel?.text = state.yPercentageName
            bSubstanceXLabel?.text = state.xPercentageName
            bSubstanceYLabel?.text = state.yPercentageName
        }
    }
    
    weak var delegate: StrainsViewDelegate?
    weak var textFieldDelegate: DecimalNumberValidator?
    
    struct State {
        var aSubstanceXPercentage: String = ""
        var aSubstanceYPercentage: String = ""
        var bSubstanceXPercentage: String = ""
        var bSubstanceYPercentage: String = ""
        
        var aSubstanceTitle: String? = nil
        var bSubstanceTitle: String? = nil
        
        var xPercentageName: String = ""
        var yPercentageName: String = ""
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        aSubstanceXPercentageField.delegate = textFieldDelegate
        aSubstanceYPercentageField.delegate = textFieldDelegate
        bSubstanceXPercentageField.delegate = textFieldDelegate
        bSubstanceYPercentageField.delegate = textFieldDelegate
        
        // Do any additional setup after loading the view.
        
        //Admob
        //MARK: - google Adwords
        #if RELEASE
        // Live AdMob Banner ID
        strainsBanner.adUnitID = "ca-app-pub-3940256099942544/6300978111"
        #else
        // Test AdMob Banner ID
        strainsBanner.adUnitID = "ca-app-pub-3940256099942544/2934735716"
        #endif
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
        return (!state.aSubstanceXPercentage.isEmpty &&
                !state.aSubstanceYPercentage.isEmpty &&
                !state.bSubstanceXPercentage.isEmpty &&
                !state.bSubstanceYPercentage.isEmpty)
    }

    @IBAction func textChanged(_ sender: Any) {
        
        state = State(
            aSubstanceXPercentage: aSubstanceXPercentageField?.text ?? "",
            aSubstanceYPercentage: aSubstanceYPercentageField?.text ?? "",
            bSubstanceXPercentage: bSubstanceXPercentageField?.text ?? "",
            bSubstanceYPercentage: bSubstanceYPercentageField?.text ?? "",
            aSubstanceTitle: aSubstanceTitleField?.text ?? "",
            bSubstanceTitle: bSubstanceTitleField?.text ?? "",
            xPercentageName: aSubstanceXLabel?.text ?? "",
            yPercentageName: aSubstanceYLabel?.text ?? "",
            bSubstanceXPercentageName: bSubstanceXLabel?.text ?? "",
            bSubstanceYPercentageName: bSubstanceYLabel?.text ?? ""
        )
        
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
