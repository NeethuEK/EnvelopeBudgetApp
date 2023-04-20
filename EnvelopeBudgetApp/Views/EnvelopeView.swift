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

    //@FetchRequest(entity: Envelopes.entity(), sortDescriptors: [])
    
    @FetchRequest(sortDescriptors: []) var Envelopes: FetchedResults<Envelope>
    
    //@FetchRequest(
      //  sortDescriptors: [NSSortDescriptor(keyPath: \Item.timestamp, ascending: true)],
      //  animation: .default)
    //private var items: FetchedResults<Item>

    var body: some View {
        TabView {
            NavigationView{
                VStack{
                    Text("Envelopes")
                        .font(.title)
                    List(Envelopes) { envelope in
                        
                        Text("\(envelope.label!)")
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
/*
    private func addItem() {
        withAnimation {
            let newItem = Item(context: viewContext)
            newItem.timestamp = Date()

            do {
                try viewContext.save()
            } catch {
                // Replace this implementation with code to handle the error appropriately.
                // fatalError() causes the application to generate a crash log and terminate. You should not use this function in a shipping application, although it may be useful during development.
                let nsError = error as NSError
                fatalError("Unresolved error \(nsError), \(nsError.userInfo)")
            }
        }
    }

    private func deleteItems(offsets: IndexSet) {
        withAnimation {
            offsets.map { items[$0] }.forEach(viewContext.delete)

            do {
                try viewContext.save()
            } catch {
                // Replace this implementation with code to handle the error appropriately.
                // fatalError() causes the application to generate a crash log and terminate. You should not use this function in a shipping application, although it may be useful during development.
                let nsError = error as NSError
                fatalError("Unresolved error \(nsError), \(nsError.userInfo)")
            }
        }
    }*/
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
