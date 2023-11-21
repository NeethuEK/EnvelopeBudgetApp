//
//  getTotalIncome.swift
//  EnvelopeBudgetApp
//
//  Created by Neethu Kuruvilla on 1/17/23.
//

import Foundation
import CoreData
import SwiftUI


func getTotalIncome(_ incomeList: FetchedResults<Incomes>, _ additionalIncomeList: FetchedResults<AdditionalIncome>) -> Double{
    
    var total : Double = 0.00
    for income in incomeList{
        total += income.monthlyAmount
    }
    
    for addIncome in additionalIncomeList{
        if addIncome.allocation == nil{
            total += addIncome.amount
        }
    }
    
    return total
}
