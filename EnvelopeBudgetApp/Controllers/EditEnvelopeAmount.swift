//
//  EditEnvelopeAmount.swift
//  EnvelopeBudgetApp
//
//  Created by Neethu Kuruvilla on 9/2/23.
//

import Foundation
import CoreData
/// Parameters:
/// transactionAmount: the amount of currency used in the transaction
/// type: type of transaction
/// envelope: the envelope connected to the transaction. Can be nil if it's an additonalincome



func subtractEnvelopeBudget(_ transactionAmount: Double, _ envelope: Envelope?){
    if envelope != nil{
        var test = envelope?.budget
        
        test = test! - transactionAmount
        
        envelope?.budget = test!
    }
    
}

func addEnvelopeBudget(_ transactionAmount: Double, _ envelope: Envelope?){
    if envelope != nil{
        var test = envelope?.budget
        
        test = test! + transactionAmount
        
        envelope?.budget = test!
    }
    
}


