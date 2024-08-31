//
//  TransactionsListView.swift
//  EnvelopeBudgetApp
//
//  Created by Neethu Kuruvilla on 8/15/23.
//


import SwiftUI

struct TransactionsListView: View {
    
    @Environment(\.managedObjectContext) var saver
    
    var listTypes = ["Expense","Additional Income","Reallocate"]
    
    @State var chosenList : String 
    
    
    var body: some View {
        
        
        NavigationView {
            VStack{
                
                
                Text("Transactions")
                    .font(.title)
                
                HStack{
                    Spacer()
                    Button("Expenses") {
                        chosenList = listTypes[0]
                    }
                    Button("Additional Incomes") {
                        chosenList = listTypes[1]
                    }
                    Button("Reallocations") {
                        chosenList = listTypes[2]
                    }
                }
                switch chosenList{
                case listTypes[0]:
                    ExpenseListView()
                    
                case listTypes[1]:
                    AdditonalIncomesListView()
                case listTypes[2]:
                    ReallocationsListView()
                default:
                    Text("Please select transaction type you'd like to see")
                }
                
                NavigationLink(destination: TransactionsCreateView(chosenList: chosenList)) {
                    Image(systemName: "plus.circle.fill")
                        .tint(.mint)
                }
                
                
            }
        }

    }
}


struct TransactionsListView_Previews: PreviewProvider {
    static var previews: some View {
        TransactionsListView(chosenList: "Expense")
    }
}
