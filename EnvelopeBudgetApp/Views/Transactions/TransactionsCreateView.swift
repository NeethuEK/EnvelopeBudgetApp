//
//  TransactionsCreateView.swift
//  EnvelopeBudgetApp
//
//  Created by Neethu Kuruvilla on 8/15/23.
//

import SwiftUI

struct TransactionsCreateView: View {
    @State var chosenList : String
    
    var body: some View {
        if chosenList == "Expense"{
            ExpenseCreationView()
        }
        else if chosenList == "Additional Income"{
            //AdditionalIncome Creation View
            AdditionalIncomesCreationView()
            
        }
        else if chosenList == "Reallocate"{
            //Reallocation Creation View
            ReallocationsCreationView()
        }
                
    }
}

struct TransactionsCreateView_Previews: PreviewProvider {
    static var previews: some View {
        TransactionsCreateView(chosenList: "Expense")
    }
}
