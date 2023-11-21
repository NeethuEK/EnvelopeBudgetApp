//
//  AdditionalIncomesCreationView.swift
//  EnvelopeBudgetApp
//
//  Created by Neethu Kuruvilla on 10/23/23.
//

import SwiftUI

struct AdditionalIncomesCreationView: View {
    @State var amount : Double = 0.00
    @State var payer : String = ""
    @State var title : String = ""
    @State var dateOf : Date = .now
    @State var note : String = ""
    @State var allocation : FetchedResults<Envelope>.Element? = nil
    @State private var goToEnvelope : Bool = false
    
    @FetchRequest(sortDescriptors: []) var Envelopes: FetchedResults<Envelope>
    
    @State var showSaveConfimation : Bool = false
    
    @State var showPayerMissingAlert : Bool = false
    
    @Environment(\.managedObjectContext) var saver
    
    @Environment(\.dismiss) private var dismiss
    
    var body: some View {
        VStack{
            TextField("Title(Optional)", text: $title)
                .textFieldStyle(.roundedBorder)
                .background(Color.white)
            
            TextField("Amount", value: $amount, format: .currency(code: Locale.current.currency?.identifier ?? "USD"))
                .keyboardType(.decimalPad)
                .background(Color.white)
                .textFieldStyle(.roundedBorder)
            
            TextField("Payer", text: $payer)
            
            Toggle(isOn: $goToEnvelope) {
                Text("Funds will go straight to an envelope")
            }
            .toggleStyle(.switch)
            
            if goToEnvelope == true{
                Picker("Select Envelope", selection: $allocation) {
                    ForEach(Envelopes, id: \.self){ envelope in
                        Text(envelope.label ?? "?").tag(envelope as Envelope?)
                        
                    }
                }
            }
            
            DatePicker(selection: $dateOf, displayedComponents: .date) {
                Text("Select Date")
                
            }
            
            TextField("Description(Optional)", text: $note)
                .textFieldStyle(.roundedBorder)
                .background(Color.white)
            
            Button("Save") {
                if payer.isEmpty{
                    showPayerMissingAlert = true
                }
                else{
                    showSaveConfimation = true
                }
            }.alert("Payer is required", isPresented: $showPayerMissingAlert) {
                Button("OK", role: .cancel) {}
            }
            .confirmationDialog("Are you sure you want to save?", isPresented: $showSaveConfimation) {
                Button("Save") {
                    let additonalIncome = AdditionalIncome(context: saver)
                    
                    additonalIncome.payer = payer
                    additonalIncome.title = title
                    additonalIncome.dateOf = dateOf
                    additonalIncome.note = note
                    
                    additonalIncome.willGoToEnvelope = goToEnvelope
                    
                    let roundedAmount = decimalRounding(amount)
                    
                    if goToEnvelope == true{
                        additonalIncome.env = allocation
                        if allocation?.budget != nil{
                            allocation?.budget = allocation!.budget + roundedAmount
                        }else{
                            print("ENVELOPE NIL")
                        }
                    } else{
                        additonalIncome.allocation = nil
                        additonalIncome.env = nil
                        //Adding to base allocation
                    }
                    
                    
                    
                    additonalIncome.amount = roundedAmount
                    
                    do{
                        try saver.save()
                        dismiss.self.callAsFunction()
                        print("Saving Additional Income")
                        
                    }catch{
                        print("Issue saving additional Income")
                    }
                    
                }
                Button("Cancel",role: .cancel) {}
            }
        }
    }
}

struct AdditionalIncomesCreationView_Previews: PreviewProvider {
    static var previews: some View {
        AdditionalIncomesCreationView()
    }
}
