//
//  DismissKeyboardViewController.swift
//  Ratios
//
//  Created by James Pamplona on 4/5/18.
//  Copyright © 2018 James Pamplona. All rights reserved.
//

import UIKit

class DismissKeyboardViewController: UIViewController {
    /// If needed, this class would be a good place to also add functionality related to not covering up text fields or buttons in response to the keyboard appearing/disappearing
    override func touchesBegan(_ touches: Set<UITouch>, with event: UIEvent?) {
        view.endEditing(true)
        super.touchesBegan(touches, with: event)
    }
}
