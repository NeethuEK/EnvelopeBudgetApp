//
//  DecimalRounding.swift
//  EnvelopeBudgetApp
//
//  Created by Neethu Kuruvilla on 12/15/22.
//

import Foundation

func decimalRounding(_ value: Double) -> Double{
    let roundingResult = Double(round(100 * value)/100)
    
    return roundingResult
}

func convert(_ a: Double, maxDecimals max: Int) -> Double {
    let stringArr = String(a).split(separator: ".")
    let decimals = Array(stringArr[1])
    var string = "\(stringArr[0])."

    var count = 0;
    for n in decimals {
        if count == max { break }
        string += "\(n)"
        count += 1
    }


    let double = Double(string)!
    return double
}
