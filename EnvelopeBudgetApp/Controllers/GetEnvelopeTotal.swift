//
//  GetEnvelopeTotal.swift
//  EnvelopeBudgetApp
//
//  Created by Neethu Kuruvilla on 3/20/23.
//

import Foundation
import CoreData
import SwiftUI

func getEnvelopeTotal(_ envelopeList: FetchedResults<Envelope>) -> Double{
    var result : Double = 0
    
    for envelope in envelopeList{
        result += envelope.budget
    }
    
    return result
}
