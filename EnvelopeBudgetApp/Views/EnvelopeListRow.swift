//
//  EnvelopeListRow.swift
//  EnvelopeBudgetApp
//
//  Created by Neethu Kuruvilla on 4/27/23.
//

import SwiftUI
import CoreData

struct EnvelopeListRow: View {
    var envelope: FetchedResults<Envelope>.Element
    
    var body: some View {
        VStack{
            
            HStack {
                if envelope.label != nil{
                    Text(envelope.label ?? "Nil")
                        .font(.callout)
                    
                    
                }
                
                
            }
            let formattedBudget = String(format: "%.2f", envelope.budget)
            Text("\(formattedBudget)")
            
        }
    }
}
func test(){
    print("Uh Oh")
}
struct EnvelopeListRow_Previews: PreviewProvider {
    
    @FetchRequest(sortDescriptors: []) static var Envelopes: FetchedResults<Envelope>
    
    static var previews: some View {
        
        if let firstExample = Envelopes.first{
            EnvelopeListRow(envelope: firstExample)
        }
    }
    
}
