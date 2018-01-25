//: Playground - noun: a place where people can play

import Foundation
import SpriteKit

struct Strain {
    let thc: Double
    let cbd: Double
}

struct DesiredRatio: CustomStringConvertible {
    var description: String {
        return "\(thc)/\(cbd)"
    }
    
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
        return Ratio(numerator: ratio.numerator / gcd, denominator: ratio.denominator / gcd)
    }
    
    private func greatestCommonDivisor(a: Int, b: Int) -> Int {
        if a == 0 {
            return b
        }
        return greatestCommonDivisor(a: b % a, b: a)
    }
}

func greatestCommonDivisor(a: Int, b: Int) -> Int {
    if a == 0 {
        return b
    }
    return greatestCommonDivisor(a: b % a, b: a)
}

func reduce(ratio: Ratio) -> Ratio {
    let gcd = greatestCommonDivisor(a: ratio.numerator, b: ratio.denominator)
    return Ratio(numerator: ratio.numerator / gcd, denominator: ratio.denominator / gcd)
}

let ratio = Ratio(numerator: 60, denominator: 50)

reduce(ratio: ratio)
reduce(ratio: Ratio(numerator: 25, denominator: 75))
reduce(ratio: Ratio(numerator: 333, denominator: 1000))



let cbdStrain = Strain(thc: 2, cbd: 8)
let thcStrain = Strain(thc: 10, cbd: 4)
var totalFinalTHCY: Double
var totalFinalCBDY: Double

let cbdSlope = ((cbdStrain.cbd - thcStrain.cbd) / 100)
let thcSlope = ((cbdStrain.thc - thcStrain.thc) / 100)
let thcYIntercept = thcStrain.thc
let cbdYIntercept = thcStrain.cbd

for percentCBDStrain in 0...100 {

    let thcX = percentCBDStrain
    let cbdX = percentCBDStrain
    
    totalFinalTHCY =  thcSlope * Double(thcX) + thcYIntercept
    totalFinalCBDY =  cbdSlope * Double(cbdX) + cbdYIntercept

    
}
let desiredRatio: DesiredRatio = DesiredRatio(thc: 1, cbd: 2)

let m1 = cbdSlope
let m2 = thcSlope
let b1 = cbdYIntercept
let b2 = thcYIntercept
let thcFactor = desiredRatio.thc
let cbdFactor = desiredRatio.cbd
let xIntersection = (thcFactor * b2 - cbdFactor * b1) / (m1 - m2)
let xIntersection2 = (thcStrain.thc - thcStrain.cbd) / ( ((cbdStrain.cbd - thcStrain.cbd) / Double((100 - 0))) + ((thcStrain.thc - cbdStrain.thc) / Double((100 - 0))) )
let yInterception = thcSlope * xIntersection + thcYIntercept
let yInterception2 = cbdSlope * xIntersection + cbdYIntercept
let reducedRatio = Ratio(numerator: Int(100 - xIntersection), denominator: Int(xIntersection)).reduced


