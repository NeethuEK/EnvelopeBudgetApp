//
//  EnvelopeCreateView.swift
//  EnvelopeBudgetApp
//
//  Created by Neethu Kuruvilla on 1/24/23.
//

import SwiftUI



struct EnvelopeCreateView: View {
    @FetchRequest(sortDescriptors: []) var incomes: FetchedResults<Incomes>
    
    @Environment(\.managedObjectContext) var saver
    
    @State var allocatedAmount : Double = 0
    
    @State var maxAmount : Double = 0
    
    @State var envelopeTitle : String = ""
    
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
                    
                    //check if allocated amount is greater than max amount
                    if allocatedAmount > maxAmount{
                        //alert
                    }else if envelopeTitle.isEmpty{
                        //alert
                    }else{
                        do{
                            let roundedAllocation = decimalRounding(allocatedAmount)
                            
                            let envelope = Envelope(context: saver)
                            envelope.budget = roundedAllocation
                            envelope.label = envelopeTitle
                            
                            try? saver.save()
                        } catch{
                            print("Issue saving envelope")
                        }
                        
                        
                        
                    }
                }
                .padding()
                .foregroundColor(.black)
                .background(Color.mint)
                .clipShape(Capsule())
                    
                
            }
        )
    }
    
    func getmaxAmount() -> Double{
        let max = getTotalIncome(incomes)
        
        return max
    }
}

struct EnvelopeCreateView_Previews: PreviewProvider {
    static var previews: some View {
        EnvelopeCreateView()
    }
}
