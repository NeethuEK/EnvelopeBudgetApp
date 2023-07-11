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
        var periodplace = Int(paymentPeriodNumber - 1)
        var temp = periods[periodplace]
        var weekTemp = periods[0]
        periods[0] = temp
        periods[periodplace] = "Weekly"
    }
    
    return periods
}
