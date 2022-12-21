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
