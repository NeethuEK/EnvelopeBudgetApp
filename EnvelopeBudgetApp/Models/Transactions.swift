//
//  Transactions.swift
//  EnvelopeBudgetApp
//
//  Created by Neethu Kuruvilla on 8/24/23.
//

import Foundation

protocol transaction{
    
    var date: Date {get set}
}

enum transaction{
    case expense, additionalIncome
}
