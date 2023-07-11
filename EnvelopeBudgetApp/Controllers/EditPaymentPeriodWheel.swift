//
//  EditPaymentPeriodWheel.swift
//  EnvelopeBudgetApp
//
//  Created by Neethu Kuruvilla on 7/3/23.
//

import Foundation

func editPaymentPeriodWheel(_ paymentPeriodNumber: Int16) -> [String]{
    var periods = ["Weekly", "Biweekly", "Semimonthly", "Monthly"]
    
    if paymentPeriodNumber != 1{
        let periodplace = Int(paymentPeriodNumber - 1)
        let temp = periods[periodplace]
        periods[0] = temp
        periods[periodplace] = "Weekly"
    }
    
    return periods
}
