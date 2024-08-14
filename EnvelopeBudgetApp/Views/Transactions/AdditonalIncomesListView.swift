//
//  AdditonalIncomesListView.swift
//  EnvelopeBudgetApp
//
//  Created by Neethu Kuruvilla on 10/18/23.
//

import SwiftUI

struct AdditonalIncomesListView: View {
    @Environment(\.managedObjectContext) var saver
    
    @FetchRequest(sortDescriptors: [
        SortDescriptor(\.dateOf)
    ]) var additionalIncomes: FetchedResults<AdditionalIncome>
    
    @State private var showingDeleteAlert = false
    
    @State private var addiIncometoDelete: FetchedResults<AdditionalIncome>.Element? = nil
    
    var body: some View {
        List{
            ForEach(additionalIncomes) { addIncome in
                AdditionalIncomeRow(additonalIncome: addIncome)
                    .swipeActions {
                        Button("Delete", role: .destructive) {
                            //TODO: add Alert so that user knows that envelope amount might change, change showDeleteAlert to true
                            self.addiIncometoDelete = addIncome
                            showingDeleteAlert = true
                        }
                    }.confirmationDialog("Are you sure you want to delete this? Doing so will subtract the amount from whatever Envelope it was assigned to at creation", isPresented: $showingDeleteAlert, titleVisibility: .visible) {
                        //TODO: make delete and cancel button
                        Button("Delete",role: .destructive) {
                            if addiIncometoDelete?.env != nil && addiIncometoDelete?.amount != nil{
                                 
                                addiIncometoDelete!.env?.budget = addiIncometoDelete!.env!.budget - addiIncometoDelete!.amount
                            }
                            if addiIncometoDelete != nil{
                                saver.delete(addiIncometoDelete!)
                            }
                        }
                        Button("Cancel",role: .cancel) {
                            showingDeleteAlert = false
                        }
                    }
            }
        }
    }
}

struct AdditonalIncomesListView_Previews: PreviewProvider {
    static var previews: some View {
        AdditonalIncomesListView()
    }
}
