//
//  OnboardingViewController.swift
//  Ratios
//
//  Created by Justin Reed on 4/7/18.
//  Copyright © 2018 James Pamplona. All rights reserved.
//

import UIKit

enum ChallengeAnswer: Int {
    case minorOrUnanswered = 0
    case over21 = 1
}

class OnboardingViewController: UIViewController, StoryboardInitializable {

    weak var delegate: OnboardingViewDelegate?
    
    override func viewDidLoad() {
        super.viewDidLoad()

        // Do any additional setup after loading the view.
    }
    
    @IBAction func answeredMinor() {
        delegate?.challengeAnswered(answer: .minorOrUnanswered)
    }
    
    @IBAction func answeredOver21() {
        delegate?.challengeAnswered(answer: .over21)
    }
}
