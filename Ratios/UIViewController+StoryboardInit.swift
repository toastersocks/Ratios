//
//  UIViewController+StoryboardInit.swift
//
//  Created by James Pamplona on 5/24/17.
//  Copyright © 2017 James Pamplona. All rights reserved.
//

import UIKit


/// A resource that can be instantiated from a UIStoryboard and has an associated storyboard identifier
protocol StoryboardInitializable {
    static var storyboardID: String { get }
}

extension StoryboardInitializable where Self: UIViewController {
    
    static var storyboardID: String { return String(describing: Self.self) }
    
    
    /// Instantiate a UIViewController or subclass from a UIStoryboard.
    ///
    /// - Parameter storyboard: A UIStoryboard to load the controller from. Defaults to "Main.storyboard" from the main application bundle
    /// - Returns: A UIViewController or subclass
    static func instantiate(from storyboard: UIStoryboard = UIStoryboard(name: "Main", bundle: nil)) -> Self {
        guard let vc = storyboard.instantiateViewController(withIdentifier: Self.storyboardID) as? Self else { fatalError("Could not cast viewController to type of self") }
        return vc
    }
}

 enum ViewControllerLoadingError: Error {
    case CouldNotLoadViewControllerFromStoryboard
    case CouldNotCastToTypeofSelf
}
