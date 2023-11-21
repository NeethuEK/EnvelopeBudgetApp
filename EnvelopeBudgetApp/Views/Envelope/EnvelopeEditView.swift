//
//  EnvelopeEditView.swift
//  EnvelopeBudgetApp
//
//  Created by Neethu Kuruvilla on 7/12/23.
//

//testing testing 

import SwiftUI
import CoreData

extension Binding {
     func toUnwrapped<T>(defaultValue: T) -> Binding<T> where Value == Optional<T>  {
        Binding<T>(
            get: {
                self.wrappedValue ?? defaultValue
            },
            set: {
                self.wrappedValue = $0
            }
        )
    }
}

struct EnvelopeEditView: View {
    
    @State var selectedEnvelope: FetchedResults<Envelope>.Element
    
    @State var maxAmount : Double = 0
    
    @FetchRequest(sortDescriptors: []) var incomes: FetchedResults<Incomes>
    
    @FetchRequest(sortDescriptors: []) var additonalIncomes: FetchedResults<AdditionalIncome>
    
    @FetchRequest(sortDescriptors: []) var Envelopes: FetchedResults<Envelope>
    
    @Environment(\.managedObjectContext) var saver
    
    @State private var showEmptyNameAlert = false
    
    @State private var showExcessAmountAlert = false
    
    var body: some View {
        Color("BackgroundMint")
            .overlay(
                VStack{
                    
                    TextField("Envelope Name", text: $selectedEnvelope.label.toUnwrapped(defaultValue: " "))
                        .background(Color.white)
                        .textFieldStyle(.roundedBorder)
                    
                    HStack{
                        let max = getMaxforEditingEnvelope()
                        Spacer()
                        Slider(value: $selectedEnvelope.budget, in: 0.00...max)
                        
                        TextField("", value: $selectedEnvelope.budget, format: .currency(code: Locale.current.currency?.identifier ?? "USD"))
                            .keyboardType(.decimalPad)
                            .background(Color.white)
                            .textFieldStyle(.roundedBorder)
                        Spacer()
                        
                    }
                    
                    Button("Save") {
                        maxAmount = getMaxforEditingEnvelope()
                        print("Max Amount: \(maxAmount)")
                        if selectedEnvelope.budget > maxAmount{
                            showExcessAmountAlert = true
                        } else if ((selectedEnvelope.label?.isEmpty) == true){
                            showEmptyNameAlert = true
                        } else if selectedEnvelope.hasChanges{
                            let newAllocation = decimalRounding(selectedEnvelope.budget)
                            
                            do{
                                try selectedEnvelope.budget = newAllocation
                                
                                try? saver.save()
                            }catch{
                                print(error.localizedDescription)
                                
                            }
                            
                        }
                    }
                    .alert("Not enough money in available total budget. Please lower the amount in this or another envelope to be able to save.", isPresented: $showExcessAmountAlert, actions: {
                        Button("OK",role: .cancel) {}
                    })
                    .alert("Title required before saving", isPresented: $showEmptyNameAlert, actions: {
                        Button("OK",role: .cancel) {}
                    })
                }
        )
    }
    
    func getMaxforEditingEnvelope() -> Double{
        let max = getTotalIncome(incomes, additonalIncomes) - getEnvelopeTotal(Envelopes) + selectedEnvelope.budget
        
        return max
    }
}
