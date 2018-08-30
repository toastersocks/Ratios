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

/*
protocol OnboardingViewDelegate: class {
    func challengeAnswered(answer: ChallengeAnswer)
}
*/


/// Coordinates views and responds to user actions
final class Coordinator {
    
    var ratioState: RatioViewController.State = RatioViewController.State()
    var navigationController: UINavigationController
    let validator = DecimalNumberValidator()
    
    init(with navController: UINavigationController) {
        self.navigationController = navController
    }
    
    func start() {
        
//        switch ChallengeAnswer(rawValue: UserDefaults().integer(forKey: "challengeAnswer")) {
        
//            case .over21?:
                let ratioVC = RatioViewController.instantiate()
                ratioVC.delegate = self
                ratioVC.textFieldDelegate = validator
                navigationController.setViewControllers([ratioVC], animated: false)
//            case .minorOrUnanswered?, nil:
//                let onboardingVC = OnboardingViewController.instantiate()
//                onboardingVC.delegate = self
//                navigationController.setViewControllers([onboardingVC], animated: false)
//            }
    }
    
}

// MARK: - RatioViewDelegate
extension Coordinator: RatioViewDelegate {
    
    func nextTapped(with state: RatioViewController.State) {
        ratioState = state
        let strainsVC = StrainsViewController.instantiate()
        strainsVC.delegate = self
        strainsVC.textFieldDelegate = validator
        navigationController.pushViewController(strainsVC, animated: true)
    }
}


/*
extension Coordinator: OnboardingViewDelegate {
    func challengeAnswered(answer: ChallengeAnswer) {
        switch answer {
        case .minorOrUnanswered:
            print("User is a minor")
        case .over21:
            UserDefaults().set(answer.rawValue, forKey: "challengeAnswer")
            let ratiosVC = RatioViewController.instantiate()
            ratiosVC.delegate = self
            navigationController.setViewControllers([ratiosVC], animated: true)
        }
    }
}
*/

extension Coordinator: StrainsViewDelegate {
    
    fileprivate func showErrorDialogue() {
        let alert = UIAlertController(title: "Oops", message: "Your desired ratio can't be achieved using the strains you've entered. Try a different ratio or use different strains. Ratios works best using one CBD strain and one THC strain", preferredStyle: .alert)
        alert.addAction(UIAlertAction(title: "Ok", style: .default))
        navigationController.present(alert, animated: true)
    }
    
    func nextTapped(with state: StrainsViewController.State) {
        guard let thcStrainTHCPercentage = Double(state.aSubstanceXPercentage),
            let thcStrainCBDPercentage = Double(state.aSubstanceYPercentage),
            let cbdStrainTHCPercentage = Double(state.bSubstanceXPercentage),
            let cbdStrainCBDPercentage = Double(state.bSubstanceYPercentage),
            let desiredTHCFactor = Double(ratioState.xRatio),
            let desiredCBDFactor = Double(ratioState.yRatio)
            else { fatalError("Invalid input not handled") }
        
        let thcStrain = Strain(thc: thcStrainTHCPercentage, cbd: thcStrainCBDPercentage)
        let cbdStrain = Strain(thc: cbdStrainTHCPercentage, cbd: cbdStrainCBDPercentage)
        
        let ratiosAlgorithm = RatiosAlgorithm(
            thcStrain: thcStrain,
            cbdStrain: cbdStrain,
            desiredTHCFactor: desiredTHCFactor,
            desiredCBDFactor: desiredCBDFactor
        )
        
        do {
            
            let finalMix = try ratiosAlgorithm.calculateRatio()
            let cannabinoidPercentages = try ratiosAlgorithm.cannabinoidPercentages(atCBDRatio: ratiosAlgorithm.finalCBDMixPercentage())
            
            var forMessage: String
            
            forMessage = """
            \(ratioState.xRatio):\(ratioState.yRatio) thc to cbd
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
                    else { fatalError("Invalid user input not handled (not validated)") }
                
                
                let thcGrams = try ratiosAlgorithm.finalTHCMixPercentage() * 0.01 * totalGrams
                let cbdGrams = try ratiosAlgorithm.finalCBDMixPercentage() * 0.01 * totalGrams
                
                forMessage = "\(totalGramsString) grams of " + forMessage
                
                mixMessage = """
                \(String(format: "%.2f", thcGrams)) grams of thc strain
                \(String(format: "%.2f", cbdGrams)) grams of cbd strain
                """
            }
            
            let results = ResultsViewController.State(
                forMessage: forMessage,
                mixMessage: mixMessage,
                accessibleMixMessage: "Mix " + mixMessage.formatDecimalNumbersForAccessibility().replacingOccurrences(of: "\n", with: " with ") + ".",
                accessibleForMessage: "For " + forMessage.formatDecimalNumbersForAccessibility().replacingOccurrences(of: ":", with: " to ").replacingOccurrences(of: "\n", with: ", ") + ".")
            
            
            let resultsVC = ResultsViewController.instantiate()
            resultsVC.delegate = self
            resultsVC.state = results
            navigationController.pushViewController(resultsVC, animated: true)

        } catch {
            showErrorDialogue()
        }
        
    }
}

extension Coordinator: ResultsViewDelegate {
    
    func newRatioTapped(with state: ResultsViewController.State) {
        start()
    }
}

