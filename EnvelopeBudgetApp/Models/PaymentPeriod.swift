//
//  PaymentPeriod.swift
//  EnvelopeBudgetApp
//
//  Created by Neethu Kuruvilla on 11/21/23.
//

import Foundation

protocol PaymentPeriod {
    var type : String { get }
}

struct Monthly : PaymentPeriod {
    var type = "Monthly"
}
