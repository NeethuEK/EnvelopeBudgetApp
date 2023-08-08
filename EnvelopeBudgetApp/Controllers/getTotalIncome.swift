//
//  getTotalIncome.swift
//  EnvelopeBudgetApp
//
//  Created by Neethu Kuruvilla on 1/17/23.
//

import Foundation
import CoreData
import SwiftUI

func getTotalIncome(_ incomeList: FetchedResults<Incomes>) -> Double{
    var total : Double = 0.00
    for income in incomeList{
        total += income.monthlyAmount
    }
    
    
    
    return total
}
