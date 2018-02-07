//
//  DecimalNumberValidator.swift
//  Ratios
//
//  Created by James Pamplona on 2/7/18.
//  Copyright © 2018 James Pamplona. All rights reserved.
//

import UIKit


class DecimalNumberValidator: NSObject {
    
    private let formatter = NumberFormatter()
    
    func isValidDouble(from string: String, maxDecimalPlaces: Int) -> Bool {
        
        if formatter.number(from: string) != nil {
            
            let split = string.components(separatedBy: formatter.decimalSeparator ?? ".")
            
            let digits = split.count == 2 ? split.last ?? "" : ""
            
            return digits.count <= maxDecimalPlaces
        }
        return false
    }
}

extension DecimalNumberValidator: UITextFieldDelegate {
    
    func textField(_ textField: UITextField, shouldChangeCharactersIn range: NSRange, replacementString string: String) -> Bool {
        if string.isEmpty { return true }
        
        let currentText = textField.text ?? ""
        let replacementText = (currentText as NSString).replacingCharacters(in: range, with: string)
        
        return isValidDouble(from: replacementText, maxDecimalPlaces: 2)
    }
}
