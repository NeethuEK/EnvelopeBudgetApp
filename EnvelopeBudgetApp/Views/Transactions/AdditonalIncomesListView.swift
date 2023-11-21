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
                            
                            if addIncome.env != nil{
                                
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
