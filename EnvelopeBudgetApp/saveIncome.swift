//
//  saveIncome.swift
//  EnvelopeBudgetApp
//
//  Created by Neethu Kuruvilla on 12/9/22.
//

import Foundation
import CoreData

func saveIncome(_ amount: Double, _ paymentPeriod: String){
    //round to a two digit double
    
    let roundedAmount = decimalRounding(amount)
    
    //get monthly amount based off of payment period
    var monthlyAmount : Double
    switch paymentPeriod{
        
    case "Monthly":
        monthlyAmount = amount
    case "Weekly":
        monthlyAmount = amount*4
    case "Biweekly":
        monthlyAmount = (amount * 26) / 12
    case "SemiMonthly":
            monthlyAmount = (amount * 24) / 12
    default:
        print("Hi")
    }
    
    //Save it in core data
    
    
    
}
