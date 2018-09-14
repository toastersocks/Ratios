//
//  StateTransformer.swift
//  Ratios
//
//  Created by James Pamplona on 8/29/18.
//  Copyright © 2018 James Pamplona. All rights reserved.
//

import Foundation

struct StateTransformer {
    var currentState: State = .ratio(state: RatioViewController.State())
//    private var ratioState: RatioViewController.State = RatioViewController.State()
    private var ratioState: RatioViewController.State {
        switch currentState {
        case .ratio(state: let ratioState):
            return ratioState
        case .strain(state: _, let ratioState):
            return ratioState
        case .result(state: _, _, let ratioState):
            return ratioState
        }
    }
    
    mutating func next(with state: RatioViewController.State) -> StrainsViewController.State {
        var nextState = StrainsViewController.State()
        nextState.xPercentageName = state.xLabel
        nextState.yPercentageName = state.yLabel
        currentState = .strain(state: nextState, state)
        guard case .strain(let strainsState, _) = currentState else { fatalError("Couldn't get nextState value from currentState property") }
        return strainsState
    }
    
    func next(with state: StrainsViewController.State) throws -> ResultsViewController.State {
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
            
            return results
            
        } catch {
            throw error
        }
    }
}

extension StateTransformer {
    enum State {
        case ratio(state: RatioViewController.State)
        case strain(state: StrainsViewController.State, RatioViewController.State)
        case result(state: ResultsViewController.State, StrainsViewController.State, RatioViewController.State)
    }
}
