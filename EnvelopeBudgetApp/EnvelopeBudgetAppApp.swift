//
//  EnvelopeBudgetAppApp.swift
//  EnvelopeBudgetApp
//
//  Created by Neethu Kuruvilla on 10/17/22.
//

/*
 -Income creation: go toEstimatedIncomeEditView for more details
 -Calculate total monthly income
 
 
 -Create Envelope (prerequisites: access to total budget avalible)
    ?What to do with unallocated funds
 
 Current Task:
 How to set up transaction attribute of Envelopes
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
