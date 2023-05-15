//
//  availableAmountCalculations.swift
//  EnvelopeBudgetApp
//
//  Created by Neethu Kuruvilla on 5/11/23.
//

import Foundation
import CoreData
import SwiftUI

func getAvailableAmount(_ incomes: FetchedResults<Incomes>,_ envelopes: FetchedResults<Envelope>) -> Double{
    return (getTotalIncome(incomes) - getEnvelopeTotal(envelopes))
}
