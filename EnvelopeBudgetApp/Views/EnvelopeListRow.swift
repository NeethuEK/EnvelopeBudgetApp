//
//  EnvelopeListRow.swift
//  EnvelopeBudgetApp
//
//  Created by Neethu Kuruvilla on 4/27/23.
//

import SwiftUI
import CoreData


struct EnvelopeListRow: View {
    
    @Environment(\.managedObjectContext) private var viewContext
    
    var envelope: FetchedResults<Envelope>.Element
    
    
    
    var body: some View {
        
        NavigationLink(destination: EnvelopeEditView(selectedEnvelope: envelope)) {
            VStack{
                
                HStack {
                    if envelope.label != nil{
                        Text(envelope.label ?? "Nil")
                            .font(.callout)
                            .listRowBackground(Color.mint)
                        
                    }
                    
                    
                }
                
                let formattedBudget = String(format: "%.2f", envelope.budget)
                Text("\(formattedBudget)")
                
            }
        }
        
    }
    
    func getEnvelope(with id: UUID?) -> Envelope?{
        guard let id = id else{
            return nil
        }
        
        let request = Envelope.fetchRequest() as NSFetchRequest<Envelope>
        request.predicate = NSPredicate(format: "%K == %@", id as NSUUID)
        
        guard let envelopes = try? viewContext.fetch(request) else{
            return nil
        }
        
        return envelopes.first
        
    }
}
func test(){
    print("Uh Oh")
}

/*
struct EnvelopeListRow_Previews: PreviewProvider {
    
    @FetchRequest(sortDescriptors: []) static var Envelopes: FetchedResults<Envelope>
    
    static var previews: some View {
        
        if let firstExample = Envelopes.first{
            EnvelopeListRow(envelope: firstExample)
        }
    }
    
}*/
