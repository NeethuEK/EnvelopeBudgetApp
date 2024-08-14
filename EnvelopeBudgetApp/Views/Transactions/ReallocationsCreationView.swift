//
//  ReallocationsCreationView.swift
//  EnvelopeBudgetApp
//
//  Created by Neethu Kuruvilla on 10/23/23.
//

import SwiftUI

struct ReallocationsCreationView: View {
    @State var amount : Double = 0.00
    @State var title : String = ""
    @State var dateOf : Date = .now
    @State var note : String = ""
    @State var envelopeFrom : FetchedResults<Envelope>.Element? = nil
    @State var envelopeTo : FetchedResults<Envelope>.Element? = nil
    
    @FetchRequest(sortDescriptors: []) var Envelopes: FetchedResults<Envelope>
    
    @Environment(\.managedObjectContext) var saver
    
    @Environment(\.dismiss) private var dismiss
    
    @State var showSameEnvAlert : Bool = false
    
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
            
            Picker("Select Envelope to take funds from", selection: $envelopeFrom) {
                ForEach(Envelopes, id: \.self){ envelope in
                    Text(envelope.label ?? "?").tag(envelope as Envelope?)
                    
                }
            }
            
            Picker("Select Envelope to give funds to", selection: $envelopeTo) {
                ForEach(Envelopes, id: \.self){ envelope in
                    Text(envelope.label ?? "?").tag(envelope as Envelope?)
                    
                }
            }
            
            DatePicker(selection: $dateOf, displayedComponents: .date) {
                Text("Select Date")
                
            }
            
            TextField("Description(Optional)", text: $note)
                .textFieldStyle(.roundedBorder)
                .background(Color.white)
            
            Button("Save") {
                if envelopeTo == envelopeFrom{
                    showSameEnvAlert = true
                    
                    
                    
                }else{
                    showSaveConfimation = true
                }
            }.alert("The incoming and outgoing envelopes cannot be the same", isPresented: $showSameEnvAlert) {
                Button("OK", role: .cancel){}
            }.confirmationDialog("Are you sure you want to save?", isPresented: $showSaveConfimation) {
                Button("Save") {
                    let reallocation = Reallocate(context: saver)
                    
                    reallocation.date = dateOf
                    reallocation.title = title
                    reallocation.note = note
                    reallocation.sourceEnvelope = envelopeFrom
                    reallocation.destinationEnvelope = envelopeTo
                    
                    //amount
                    
                    let roundedAmount = decimalRounding(amount)
                    
                    if reallocation.sourceEnvelope?.budget != nil{
                        if reallocation.destinationEnvelope?.budget != nil {
                            subtractEnvelopeBudget(roundedAmount, reallocation.sourceEnvelope)
                            addEnvelopeBudget(roundedAmount, reallocation.destinationEnvelope)
                            
                            
                            reallocation.amount = roundedAmount
                            
                            do{
                                try saver.save()
                                dismiss.self.callAsFunction()
                                
                                
                            }catch{
                                print("Issue saving reallocation")
                            }
                        } else{
                            //error
                        }
                    } else{
                        //error
                    }
                }
                Button("Cancel", role: .cancel){}
            }
            
        }
    }
}

struct ReallocationsCreationView_Previews: PreviewProvider {
    static var previews: some View {
        ReallocationsCreationView()
    }
}
