//
//  Coordinator.swift
//  Ratios
//
//  Created by James Pamplona on 1/27/18.
//  Copyright © 2018 James Pamplona. All rights reserved.
//

import UIKit

protocol RatioViewDelegate: class {
    func nextTapped(with state: RatioViewController.State)
}

protocol StrainsViewDelegate: class {
    func nextTapped(with state: StrainsViewController.State)
}

protocol ResultsViewDelegate: class {
    func newRatioTapped(with state: ResultsViewController.State)
}


/// Coordinates views and responds to user actions
final class Coordinator {
    
    var ratioState: RatioViewController.State = RatioViewController.State()
    var navigationController: UINavigationController
    let validator = DecimalNumberValidator()
    
    init(with navController: UINavigationController) {
        self.navigationController = navController
    }
    
    func start() {
        navigationController.setViewControllers([UIViewController](), animated: false)
        let ratioVC = RatioViewController.instantiate()
        ratioVC.delegate = self
        ratioVC.textFieldDelegate = validator
        navigationController.pushViewController(ratioVC, animated: true)
    }
    
}

extension Coordinator: RatioViewDelegate {
    
    func nextTapped(with state: RatioViewController.State) {
        ratioState = state
        let strainsVC = StrainsViewController.instantiate()
        strainsVC.delegate = self
        strainsVC.textFieldDelegate = validator
        navigationController.pushViewController(strainsVC, animated: true)
    }
}

extension Coordinator: StrainsViewDelegate {
    
    func nextTapped(with state: StrainsViewController.State) {
        guard let thcStrainTHCPercentage = Double(state.thcStrainTHCPercentage),
              let thcStrainCBDPercentage = Double(state.thcStrainCBDPercentage),
              let cbdStrainTHCPercentage = Double(state.cbdStrainTHCPercentage),
              let cbdStrainCBDPercentage = Double(state.cbdStrainCBDPercentage),
              let desiredTHCFactor = Double(ratioState.thcRatio),
              let desiredCBDFactor = Double(ratioState.cbdRatio)
            // TODO: Validate user input
            else { fatalError("Invalid input not handled") }
        
        let thcStrain = Strain(thc: thcStrainTHCPercentage, cbd: thcStrainCBDPercentage)
        let cbdStrain = Strain(thc: cbdStrainTHCPercentage, cbd: cbdStrainCBDPercentage)
        
        let ratiosAlgorithm = RatiosAlgorithm(
            thcStrain: thcStrain,
            cbdStrain: cbdStrain,
            desiredTHCFactor: desiredTHCFactor,
            desiredCBDFactor: desiredCBDFactor
        )
        let finalMix = ratiosAlgorithm.calculateRatio()
        let cannabinoidPercentages = ratiosAlgorithm.cannabinoidPercentages(atCBDRatio: ratiosAlgorithm.finalCBDMixPercentage())
        
        var forMessage: String
        
        forMessage = """
                    \(ratioState.thcRatio):\(ratioState.cbdRatio) thc to cbd
                    \(String(format: "%.2f", cannabinoidPercentages.thc))% thc \(String(format: "%.2f", cannabinoidPercentages.cbd))% cbd
                    """
        
        let mixMessage: String
        if ratioState.grams == nil || ratioState.grams!.isEmpty {
            mixMessage = """
                        \(finalMix.numerator) parts of high thc strain
                        \(finalMix.denominator) parts of high cbd strain
                        """
        } else {
            guard let totalGramsString = ratioState.grams,
                  let totalGrams = Double(totalGramsString)
                // TODO: Validate user input
                else { fatalError("Invalid user input not handled (not validated)") }
            
            
            let thcGrams = (100 - ratiosAlgorithm.finalCBDMixPercentage()) * 0.01 * totalGrams
            let cbdGrams = ratiosAlgorithm.finalCBDMixPercentage() * 0.01 * totalGrams
            
            forMessage = "\(totalGramsString) grams of " + forMessage
            
            mixMessage = """
                        \(String(format: "%.2f", thcGrams)) grams of thc strain
                        \(String(format: "%.2f", cbdGrams)) grams of cbd strain
                        """
        }

        let results = ResultsViewController.State(
            forMessage: forMessage,
            mixMessage: mixMessage)
        
        
        let resultsVC = ResultsViewController.instantiate()
        resultsVC.delegate = self
        resultsVC.state = results
        navigationController.pushViewController(resultsVC, animated: true)
    }
}

extension Coordinator: ResultsViewDelegate {
    
    func newRatioTapped(with state: ResultsViewController.State) {
        navigationController.popToRootViewController(animated: true)
        start()
    }
}

