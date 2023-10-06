//
//  TransactionsListView.swift
//  EnvelopeBudgetApp
//
//  Created by Neethu Kuruvilla on 8/15/23.
//


import SwiftUI

struct TransactionsListView: View {
    
    
    
    @FetchRequest(sortDescriptors: [
        SortDescriptor(\.dateOf)
    ]) var Expenses: FetchedResults<Expense>
    
    var transactionList: [Any]{
        var list = [Any]()
        list.append(Expenses)
        
        return list
        
    }
    @Environment(\.managedObjectContext) var saver
    
    @State private var expenseToDelete: FetchedResults<Expense>.Element? = nil
    
    @State private var showingDeleteAlert = false
    
    @State private var showingReturnAmountAlert = false
    
    var body: some View {
        NavigationView {
            VStack{
                
                
                Text("Transactions")
                    .font(.title)
                
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
                    
                }
                                
                NavigationLink(destination: TransactionsCreateView()) {
                    Image(systemName: "plus.circle.fill")
                        .tint(.mint)
                }
                
                
            }
        }

    }
}

struct TransactionsListView_Previews: PreviewProvider {
    static var previews: some View {
        TransactionsListView()
    }
}
