//
//  EnvelopeBudgetAppApp.swift
//  EnvelopeBudgetApp
//
//  Created by Neethu Kuruvilla on 10/17/22.
//

/*
General To Do:
 -Set up Edit income
 -Set up ability to delete income
-segue to income
 -Envelope Creation
 -Envelope listing
    -show allocated amount
    -show avalible amount
 Total income
    -set up avalible allocations
    -set up getting sum of transactions
 
 -Add total income and avalible income to bottom on incomeListView
 -Navigate to editView when click on income.
 
 -Calculate total monthly income
 
 
 -Create Envelope (prerequisites: access to total budget avalible)
    ?What to do with unallocated funds
 
 
 
 Current Task:
Create Envelopes
 OR
Create Transactions
 types users would need:
 expense
 additional income
 envelope transfer
 recive from unallocated
 
 

 
 Idea:
 Have each transaction state what envelope(s) their apart of. When you click of on a specific envelope go through the transactions and add the ones that are of that envelope to the list (sorted by date)
 */

import SwiftUI

@main
struct EnvelopeBudgetAppApp: App {
    let persistenceController = PersistenceController.shared

    var body: some Scene {
        WindowGroup {
            EnvelopeView()
                .environment(\.managedObjectContext, persistenceController.container.viewContext)
        }
    }
}
