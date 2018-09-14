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
    
    var ratioState = RatioViewController.State()
    var stateTransformer = StateTransformer()
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
        let strainsVC = StrainsViewController.instantiate()
        strainsVC.delegate = self
        strainsVC.textFieldDelegate = validator
        strainsVC.state = stateTransformer.next(with: state)
        
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
        
        do {
            let results = try stateTransformer.next(with: state)
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

