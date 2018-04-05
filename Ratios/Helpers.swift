//
//  Helpers.swift
//  Ratios
//
//  Created by James Pamplona on 4/4/18.
//  Copyright © 2018 James Pamplona. All rights reserved.
//

import UIKit

extension UIColor {
    var image: UIImage? {
        let rect = CGRect(x: 0, y: 0, width: 1, height: 1)
        UIGraphicsBeginImageContext(rect.size)
        let context = UIGraphicsGetCurrentContext()
        context?.setFillColor(cgColor)
        context?.fill(rect)
        let image = UIGraphicsGetImageFromCurrentImageContext()
        UIGraphicsEndImageContext()
        return image
    }
}

extension UIImage {
    static func pixle(ofColor color: UIColor) -> UIImage? {
        return color.image
    }
}

extension UIButton {
    func setBackgroundColor(_ color: UIColor?, for state: UIControlState) {
        setBackgroundImage(color?.image, for: state)
    }
}
