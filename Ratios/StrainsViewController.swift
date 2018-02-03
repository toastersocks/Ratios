//
//  StrainsViewController.swift
//  Ratios
//
//  Created by James Pamplona on 1/27/18.
//  Copyright © 2018 James Pamplona. All rights reserved.
//

import UIKit

class StrainsViewController: UIViewController, StoryboardInitializable {

    @IBOutlet weak var thcStrainTHCPercentageField: UITextField!
    @IBOutlet weak var thcStrainCBDPercentageField: UITextField!
    @IBOutlet weak var cbdStrainTHCPercentageField: UITextField!
    @IBOutlet weak var cbdStrainCBDPercentageField: UITextField!
    @IBOutlet weak var nextButton: UIButton!
    
    var state = State(thcStrainTHCPercentage: "", thcStrainCBDPercentage: "", cbdStrainTHCPercentage: "", cbdStrainCBDPercentage: "") {
        didSet {
            thcStrainTHCPercentageField?.text = state.thcStrainTHCPercentage
            thcStrainCBDPercentageField?.text = state.thcStrainCBDPercentage
            cbdStrainTHCPercentageField?.text = state.cbdStrainTHCPercentage
            cbdStrainCBDPercentageField?.text = state.cbdStrainCBDPercentage
        }
    }
    
    weak var delegate: StrainsViewDelegate?
    
    struct State {
        var thcStrainTHCPercentage: String = ""
        var thcStrainCBDPercentage: String = ""
        var cbdStrainTHCPercentage: String = ""
        var cbdStrainCBDPercentage: String = ""
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        nextButton.isEnabled = false

        // Do any additional setup after loading the view.
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
    @IBAction func nextTapped() {
        delegate?.nextTapped(with: state)
    }

    @IBAction func textChanged(_ sender: Any) {
        
        state = State(
            thcStrainTHCPercentage: thcStrainTHCPercentageField.text ?? "",
            thcStrainCBDPercentage: thcStrainCBDPercentageField.text ?? "",
            cbdStrainTHCPercentage: cbdStrainTHCPercentageField.text ?? "",
            cbdStrainCBDPercentage: cbdStrainCBDPercentageField.text ?? "")
        
        nextButton.isEnabled = (
            !state.thcStrainTHCPercentage.isEmpty &&
            !state.thcStrainCBDPercentage.isEmpty &&
            !state.cbdStrainTHCPercentage.isEmpty &&
            !state.cbdStrainCBDPercentage.isEmpty
        )
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
