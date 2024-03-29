//
//  RatiosAlgorithm.swift
//  Ratios
//
//  Created by James Pamplona on 1/31/18.
//  Copyright © 2018 James Pamplona. All rights reserved.
//

import Foundation

struct Strain {
    let thc: Double
    let cbd: Double
}

struct Ratio: CustomStringConvertible {
    var description: String {
        return "\(numerator)/\(denominator)"
    }
    
    let numerator: Int
    let denominator: Int
    
    var reduced: Ratio {
        let gcd = greatestCommonDivisor(a: numerator, b: denominator)
        return Ratio(numerator: numerator / gcd, denominator: denominator / gcd)
    }
    
    private func greatestCommonDivisor(a: Int, b: Int) -> Int {
        if a == 0 {
            return b
        }
        return greatestCommonDivisor(a: b % a, b: a)
    }
}

enum AlgorithmError: Error {
    case notANumber
    case infinite
    case resultOutOfBounds
}

/// Encapsulates the algorithms needed to calculate various properties pertaining to mixing strains of cannabis

struct RatiosAlgorithm {
    let thcStrain: Strain
    let cbdStrain: Strain
    let desiredTHCFactor: Double
    let desiredCBDFactor: Double
    private let thcYIntercept: Double
    private let cbdYIntercept: Double
    private let thcSlope: Double
    private let cbdSlope: Double
    
    init(thcStrain: Strain, cbdStrain: Strain, desiredTHCFactor: Double, desiredCBDFactor: Double) {
        self.thcStrain = thcStrain
        self.cbdStrain = cbdStrain
        self.desiredTHCFactor = desiredTHCFactor
        self.desiredCBDFactor = desiredCBDFactor
        thcYIntercept = thcStrain.thc
        cbdYIntercept = thcStrain.cbd
        thcSlope = (cbdStrain.thc - thcStrain.thc) / 100
        cbdSlope = (cbdStrain.cbd - thcStrain.cbd) / 100
    }
    

    /// Calculates the percentages of cannabinoids (THC & CBD) given a percent of CBD strain in the final mix
    ///
    /// - Parameter cbdRatio: The ratio of CBD strain in the mix (between 0 and 100 percent)
    /// - Returns: Returns a Strain value with the percentages of THC and CBD in the mix
    func cannabinoidPercentages(atCBDRatio cbdRatio: Double) -> Strain {
        let totalFinalTHCY =  thcSlope * cbdRatio + thcYIntercept
        let totalFinalCBDY =  cbdSlope * cbdRatio + cbdYIntercept
        
        return Strain(thc: totalFinalTHCY, cbd: totalFinalCBDY)
    }
    
    
    /// Calculates the percent of CBD strain needed to get the desired ratio of CBD & THC percentages in the final mix
    ///
    /// - Returns: The percent of CBD strain which will be in the final mix
    func finalCBDMixPercentage() throws -> Double {
        let b1 = thcStrain.cbd // CBD y-intercept
        let b2 = thcStrain.thc // THC y-intercept
        let m1 = (cbdStrain.cbd - thcStrain.cbd) / 100 // CBD slope
        let m2 = (cbdStrain.thc - thcStrain.thc) / 100 // THC slope
        // (t * b1 - c * b2) / (c * m2 - t * m1)
        let result = (desiredTHCFactor * b1 - desiredCBDFactor * b2) / (desiredCBDFactor * m2 - desiredTHCFactor * m1)
        
        if (0...100).contains(result) {
            return result
          // errors
        } else if result.isNaN {
            throw AlgorithmError.notANumber
        } else if result.isInfinite {
            throw AlgorithmError.infinite
        } else {
            throw AlgorithmError.resultOutOfBounds
        }

    }
    
    /// Calculates the percent of THC strains needed to get the desired ratio of CBD & THC percentages in the final mix
    ///
    /// - Returns: The percent of THC strain which will be in the final mix
    func finalTHCMixPercentage() throws -> Double {
        let result: Double
        do {
            try result = 100.0 - finalCBDMixPercentage()
        } catch {
            throw error
        }
        
        return result
    }
    
    func calculateRatio() throws -> Ratio {
        let result: Ratio
        do {
            result = try Ratio(numerator: Int(finalTHCMixPercentage().rounded()),
                               denominator: Int(finalCBDMixPercentage().rounded()))
                .reduced
        } catch {
            throw error
        }
        
        return result
    }
}
