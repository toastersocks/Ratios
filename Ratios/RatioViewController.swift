//
//  RatioViewController.swift
//  Ratios
//
//  Created by James Pamplona on 1/27/18.
//  Copyright © 2018 James Pamplona. All rights reserved.
//

import UIKit

class RatioViewController: UIViewController, StoryboardInitializable {

    @IBOutlet weak var desiredTHCRatioField: UITextField!
    @IBOutlet weak var desiredCBDRatioField: UITextField!
    @IBOutlet weak var gramsField: UITextField!
    @IBOutlet weak var nextButton: UIButton!
    
    var state = State(thcRatio: "", cbdRatio: "", grams: nil) {
        didSet {
            desiredTHCRatioField?.text = state.thcRatio
            desiredCBDRatioField?.text = state.cbdRatio
            gramsField?.text = state.grams
        }
    }
    
    weak var delegate: RatioViewDelegate?
    
    struct State {
        var thcRatio: String = ""
        var cbdRatio: String = ""
        var grams: String?
        
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
            thcRatio: desiredTHCRatioField.text ?? "",
            cbdRatio: desiredCBDRatioField.text ?? "",
            grams: gramsField.text)
        
        nextButton.isEnabled = (!state.thcRatio.isEmpty && !state.cbdRatio.isEmpty)
    }
}
