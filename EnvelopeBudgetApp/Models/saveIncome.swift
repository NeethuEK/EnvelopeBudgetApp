//
//  saveIncome.swift
//  EnvelopeBudgetApp
//
//  Created by Neethu Kuruvilla on 12/9/22.
//

import Foundation
import CoreData
import SwiftUI



func getMonthlyAmount(checkAmount: Double, paymentPeriod: String) throws -> Double{
    var monthlyAmount : Double
    monthlyAmount = -1
    switch paymentPeriod{
        
    case "Monthly":
        monthlyAmount = checkAmount
        
    case "Weekly":
        monthlyAmount = checkAmount*4
       
    case "Biweekly":
        monthlyAmount = (checkAmount * 26) / 12
    case "SemiMonthly":
        monthlyAmount = (checkAmount * 24) / 12
    default:
        throw PaymentPeriodError.invalidPaymentString
    }
    
    return monthlyAmount
}
