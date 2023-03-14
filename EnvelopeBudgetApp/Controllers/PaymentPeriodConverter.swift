//
//  PaymentPeriodConverter.swift
//  EnvelopeBudgetApp
//
//  Created by Neethu Kuruvilla on 1/10/23.
//

import Foundation

enum PaymentPeriodError: Error{
    case invalidPaymentString
    
}

func getPaymentPeriod(_ num: Int16) -> String{
    switch num{
    case 1:
        return "Weekly"
    case 2:
        return "Biweekly"
    case 3:
        return "Semimonthly"
    case 4:
        return "Monthly"
    default:
        fatalError("Invalid PaymentPeriod number")
    }
}

func getPaymentPeriodNumber(_ payPeriod: String) throws -> Int16{
    switch payPeriod{
    case "Weekly":
        return 1
    case "Biweekly":
        return 2
    case "Semimonthly":
        return 3
    case "Monthly":
        return 4
    default:
        throw PaymentPeriodError.invalidPaymentString
        
    }
}
