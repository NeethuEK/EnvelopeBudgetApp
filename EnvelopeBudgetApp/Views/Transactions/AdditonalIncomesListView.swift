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
    
    var body: some View {
        List{
            ForEach(additionalIncomes) { addIncome in
                AdditionalIncomeRow(additonalIncome: addIncome)
                    .swipeActions {
                        Button("Delete", role: .destructive) {
                            //TODO: add Alert so that user knows that envelope amount might change
                            if addIncome.env != nil{
                                addIncome.env?.budget = addIncome.env!.budget - addIncome.amount
                            }
                            saver.delete(addIncome)
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
