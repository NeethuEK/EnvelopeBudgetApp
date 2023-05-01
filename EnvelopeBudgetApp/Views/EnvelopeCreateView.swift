//
//  EnvelopeCreateView.swift
//  EnvelopeBudgetApp
//
//  Created by Neethu Kuruvilla on 1/24/23.
//

import SwiftUI



struct EnvelopeCreateView: View {
    @Environment(\.dismiss) private var dismiss
    
    @FetchRequest(sortDescriptors: []) var incomes: FetchedResults<Incomes>
    
    @FetchRequest(sortDescriptors: []) var envelopes: FetchedResults<Envelope>
    
    @Environment(\.managedObjectContext) var saver
    
    @State var allocatedAmount : Double = 0
    
    @State var maxAmount : Double = 0
    
    @State var envelopeTitle : String = ""
    
    @State private var showEmptyNameAlert = false
    
    @State private var showExcessAmountAlert = false
    
    var formatter: NumberFormatter{
        let formatter = NumberFormatter()
        formatter.numberStyle = .currency
        return formatter
    }
    
    var body: some View {
        
        Color("BackgroundMint")
            .overlay(
            VStack {
                
                TextField("Envelope Name", text: $envelopeTitle)
                    //.padding(.bottom, 40)
                    .background(Color.white)
                    .textFieldStyle(.roundedBorder)
                    
                    
                
                HStack{
                    let m = getmaxAmount()
                    Spacer()
                    Slider(value: $allocatedAmount, in: 0.0...m)
                    //totalIncome-envelopeTotal+thisenvelope
                    TextField("Amount", value: $allocatedAmount, formatter: formatter)
                        .keyboardType(.decimalPad)
                        .background(Color.white)
                        .textFieldStyle(.roundedBorder)
                    Spacer()
                }.padding(.bottom, 60)
                    .padding(.top, 40)
                    
                
                Button("Save") {
                    print("Save")
                    maxAmount = getmaxAmount()
                    //check if allocated amount is greater than max amount
                    if allocatedAmount > maxAmount{
                        //alert
                        showExcessAmountAlert = true
                    }else if envelopeTitle.isEmpty{
                        //alert
                        showEmptyNameAlert = true
                    }else{
                        
                        do{
                            let roundedAllocation = decimalRounding(allocatedAmount)
                            
                            let envelope = Envelope(context: saver)
                            envelope.budget = roundedAllocation
                            envelope.label = envelopeTitle
                            
                            try? saver.save()
                            print("saved")
                            dismiss.self.callAsFunction()
                        } catch{
                            print("Issue saving envelope")
                        }
                        
                        
                        
                        
                    }
                }
                .alert("Title required before saving", isPresented: $showEmptyNameAlert, actions: {
                    Button("OK",role: .cancel) {}
                })
                .alert("Not enough money in available total budget. Please lower the amount", isPresented: $showExcessAmountAlert, actions: {
                    Button("OK",role: .cancel) {}
                })
                .padding()
                .foregroundColor(.black)
                .background(Color.mint)
                .clipShape(Capsule())
                    
                
            }
        )
    }
    
    func getmaxAmount() -> Double{
        let max = getTotalIncome(incomes) - getEnvelopeTotal(envelopes)
        //subtract envelope totals
        //subtract tracsactions that aren't sorted into an envelope
        //add transactions
        
        return max
    }
}

struct EnvelopeCreateView_Previews: PreviewProvider {
    static var previews: some View {
        EnvelopeCreateView()
    }
}
