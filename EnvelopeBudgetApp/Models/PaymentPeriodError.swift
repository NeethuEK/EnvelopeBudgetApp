//
//  PaymentPeriodError.swift
//  EnvelopeBudgetApp
//
//  Created by Neethu Kuruvilla on 11/14/23.
//

import Foundation

enum PaymentPeriodError: Error{
    case invalidPaymentString
    
}

extension PaymentPeriodError: LocalizedError{
    
}
