//
//  ContentView.swift
//  EnvelopeBudgetApp
//
//  Created by Neethu Kuruvilla on 10/17/22.
//

import SwiftUI
import CoreData

struct EnvelopeView: View {
    @Environment(\.managedObjectContext) private var viewContext
    
    @State var showCreateView = false
    
    @State var showDeleteAlert = false

    
    @FetchRequest(sortDescriptors: []) var Envelopes: FetchedResults<Envelope>
    
    @State private var envelopeToDelete: FetchedResults<Envelope>.Element? = nil
    
    @FetchRequest(sortDescriptors: []) var incomes: FetchedResults<Incomes>

    var body: some View {
        TabView {
            NavigationView{
                Color("BackgroundMint")
                    .overlay (
                VStack{
                    Text("Envelopes")
                        .font(.title)
                        .foregroundColor(Color.init("TextColor"))
                    List{
                        ForEach(Envelopes){ envelope in
                    
                            EnvelopeListRow(envelope: envelope)                                   .swipeActions {
                                        Button("Delete",role: .destructive){
                                            self.envelopeToDelete = envelope
                                            deleteEnvelope(envelopeToDelete)
                                        }
                                    }
                            
                        }
                    }
                   
                    HStack{
                        Text(verbatim: "Available Income: ")
                            .foregroundColor(Color.init("TextColor"))
                        let availableIncome = getAvailableAmount(incomes, Envelopes)
                                            
                        let formatedAvailableIncome = String(format: "%.2f", availableIncome)
                        Text("\(formatedAvailableIncome)")
                    }
                    
                    
                    NavigationLink {
                        EnvelopeCreateView()
                    } label: {
                        Image(systemName: "plus.circle.fill")
                            .tint(.mint)
                    }
                }
                )
                
            }//NavigationView
            .onAppear()
            .tabItem {
                Image(systemName: "envelope.fill")
                    .tint(.green)
                Text("Envelopes")
                    .foregroundColor(.green)
                    
            }
            EstimatedIncomesView()
                .tabItem {
                    Image(systemName: "dollarsign.circle")
                        .tint(.green)
                    Text("Income")
                }
        }//tabView
        
    }
    
    func deleteEnvelope(_ env: FetchedResults<Envelope>.Element?){
        guard let env else { return }
        
        viewContext.delete(env)
        do {
            try viewContext.save()
        } catch {
            print("Error when deleting Envelope")
        }
    }
}

struct ContentView_Previews: PreviewProvider {
    static var previews: some View {
       // ContentView().environment(\.managedObjectContext, PersistenceController.preview.container.viewContext)
        EnvelopeView()
    }
}
