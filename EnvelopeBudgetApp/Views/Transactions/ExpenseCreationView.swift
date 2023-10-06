//
//  ExpenseCreationView.swift
//  EnvelopeBudgetApp
//
//  Created by Neethu Kuruvilla on 8/15/23.
//

/*
Current Task:
 remove amount from envelope when creating expense
        If expense is more than envelope's current amount then show alert and do not allow to save
 
 */

import SwiftUI

struct ExpenseCreationView: View {
    @State var amount : Double = 0.00
    
    @State var payee : String = ""
    
    @FetchRequest(sortDescriptors: []) var Envelopes: FetchedResults<Envelope>
    
    @Environment(\.managedObjectContext) var saver
    
    @Environment(\.dismiss) private var dismiss
    
    @State var selectedEnvelope: FetchedResults<Envelope>.Element? = nil
    
    @State var date : Date = .now
    
    @State var title : String = ""
    
    @State var description : String = ""
    
    @State var showPayeeMissingAlert : Bool = false
    
    @State var showSaveConfimation : Bool = false
    
    var body: some View {
        
        VStack{
            
            TextField("Title(Optional)", text: $title)
                .textFieldStyle(.roundedBorder)
                .background(Color.white)
            
            TextField("Amount", value: $amount, format: .currency(code: Locale.current.currency?.identifier ?? "USD"))
                .keyboardType(.decimalPad)
                .background(Color.white)
                .textFieldStyle(.roundedBorder)
            
            TextField("Payee", text: $payee)
            
            Picker("Select Envelope", selection: $selectedEnvelope) {
                ForEach(Envelopes, id: \.self){ envelope in
                    Text(envelope.label ?? "?").tag(envelope as Envelope?)
                    
                }
            }
            
            
            DatePicker(selection: $date, displayedComponents: .date) {
                Text("Select Date")
                
            }
            
            TextField("Description(Optional)", text: $description)
                .textFieldStyle(.roundedBorder)
                .background(Color.white)
            
            Button("Save") {
                //check for empty data
                if payee.isEmpty{
                    showPayeeMissingAlert = true
                } else{
                    showSaveConfimation = true
                }
                
            }.alert("Payee is required.", isPresented: $showPayeeMissingAlert) {
                Button("OK", role: .cancel) {}
            }
            .confirmationDialog("Are you sure you want to save?", isPresented: $showSaveConfimation) {
                Button("Save") {
                    let expense = Expense(context: saver)
                    
                    expense.dateOf = date
                    
                    expense.title = title
                    expense.payee = payee
                    
                    selectedEnvelope?.addToExpenseTransaction(expense)
                    
                    
                    
                    
                    
                    expense.note = description
                    
                    let roundedAmount = decimalRounding(amount)
                    
                    expense.amount = roundedAmount
                    
                    if selectedEnvelope?.budget != nil{
                        print("Selected Envelope found!")
                        selectedEnvelope?.budget = selectedEnvelope!.budget - roundedAmount
                    }
                    
                    
                    do{
                        try saver.save()
                        dismiss.self.callAsFunction()
                        print("Envelope amount:\(selectedEnvelope?.label)")
                        
                    }catch{
                        print("Issue saving expense")
                    }
                }
                
                Button("Cancel", role: .cancel) {}
            }
        }
    }
}

struct ExpenseCreationView_Previews: PreviewProvider {
    static var previews: some View {
        ExpenseCreationView()
    }
}
