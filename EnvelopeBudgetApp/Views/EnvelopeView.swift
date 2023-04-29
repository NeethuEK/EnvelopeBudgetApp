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
    
    @FetchRequest(sortDescriptors: []) var Envelopes: FetchedResults<Envelope>

    var body: some View {
        TabView {
            NavigationView{
                VStack{
                    Text("Envelopes")
                        .font(.title)
                    List(Envelopes) { envelope in
                        
                        //Text("\(envelope.label!)")
                        
                        EnvelopeListRow(envelope: envelope)
                    }
                    
                    
                    NavigationLink {
                        EnvelopeCreateView()
                    } label: {
                        Image(systemName: "plus.circle.fill")
                            .tint(.green)
                    }
                }
                
                
            }//NavigationView
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
}

private let itemFormatter: DateFormatter = {
    let formatter = DateFormatter()
    formatter.dateStyle = .short
    formatter.timeStyle = .medium
    return formatter
}()

struct ContentView_Previews: PreviewProvider {
    static var previews: some View {
       // ContentView().environment(\.managedObjectContext, PersistenceController.preview.container.viewContext)
        EnvelopeView()
    }
}
