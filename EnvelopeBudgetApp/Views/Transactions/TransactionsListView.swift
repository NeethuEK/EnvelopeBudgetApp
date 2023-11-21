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
                
                /*
                List{
                    ForEach(Expenses) { expense in
                        ExpenseRow(expense: expense)
                            .swipeActions {
                                Button("Delete", role: .destructive) {
                                    
                                    let test = expense.env
                
                                    if expense.env != nil{
                                        expenseToDelete = expense
                                        showingDeleteAlert = true
                                    }
                                    
                                    
                                    do{
                                        try saver.save()
                                    }catch{
                                        print("Error in deleting expense")
                                    }
                                }
                            }.confirmationDialog("Are you sure you want to delete this expense?", isPresented: $showingDeleteAlert) {
                                Button("Delete", role: .destructive) {
                                    //saver.delete(expense)
                                    showingDeleteAlert = false
                                    saver.delete(expense)
                                }
                                Button("Delete and return amount to Envelope", role: .destructive) {
                                    if expenseToDelete?.amount != nil && expenseToDelete?.env?.budget != nil {
                                        let expenseAmount = expenseToDelete?.amount
                                        
                                        expenseToDelete?.env?.budget += expenseAmount!
                                        
                                        saver.delete(expense)
                                    } else{
                                        //show alert that there was an issue
                                    }
                                }
                                Button("Cancel", role: .cancel) {
                                    showingDeleteAlert = false
                                }
                            }

                        
                    }
                    
                } List End*/
                                
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
