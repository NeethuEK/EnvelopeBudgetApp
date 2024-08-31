//
//  ReallocationsListView.swift
//  EnvelopeBudgetApp
//
//  Created by Neethu Kuruvilla on 10/18/23.
//

import SwiftUI

struct ReallocationsListView: View {
    @Environment(\.managedObjectContext) var saver
    
    @FetchRequest(sortDescriptors: [
        SortDescriptor(\.date)
    ]) var reallocations: FetchedResults<Reallocate>
    
    @State private var reallocToDelete: FetchedResults<Reallocate>.Element? = nil
    
    var body: some View {
        List(reallocations) { realloc in
            //TODO: addRow
            ReallocationRow(reallocationItem: realloc)
                .swipeActions {
                    Button("Delete",role: .destructive) {
                        //TODO: add deletion code
                        
                        
                        if realloc.sourceEnvelope != nil && realloc.destinationEnvelope != nil{
                        
                            subtractEnvelopeBudget(realloc.amount, realloc.destinationEnvelope)
                            addEnvelopeBudget(realloc.amount, realloc.sourceEnvelope)
                            
                            reallocToDelete = realloc
                            
                            saver.delete(reallocToDelete!)
                        }
                    }
                }
        }
    }
}

struct ReallocationsListView_Previews: PreviewProvider {
    static var previews: some View {
        ReallocationsListView()
    }
}
