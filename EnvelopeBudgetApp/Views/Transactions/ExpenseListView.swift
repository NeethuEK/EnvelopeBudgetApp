//
//  ExpenseListView.swift
//  EnvelopeBudgetApp
//
//  Created by Neethu Kuruvilla on 10/18/23.
//

import SwiftUI

struct ExpenseListView: View {
    @Environment(\.managedObjectContext) var saver
    
    @FetchRequest(sortDescriptors: [
        SortDescriptor(\.dateOf)
    ]) var Expenses: FetchedResults<Expense>
    
    @State private var expenseToDelete: FetchedResults<Expense>.Element? = nil
    
    @State private var showingDeleteAlert = false
    
    @State private var showingReturnAmountAlert = false
    
    
    var body: some View {
        List{
            ForEach(Expenses) { expense in
                ExpenseRow(expense: expense)
                    .swipeActions {
                        Button("Delete", role: .destructive) {
        
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
            
        }
    }
}

struct ExpenseListView_Previews: PreviewProvider {
    static var previews: some View {
        ExpenseListView()
    }
}
