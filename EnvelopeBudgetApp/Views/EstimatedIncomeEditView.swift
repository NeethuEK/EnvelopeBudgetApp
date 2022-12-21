//
//  EstimatedIncomeEditView.swift
//  EnvelopeBudgetApp
//
//  Created by Neethu Kuruvilla on 11/4/22.
//

import SwiftUI


/* TODO:
 * -when save button is clicked, first check if input is a valid  2 decimal float, if not then give an arror alert
 -if the float is valid, then create an Income coreData object
 */
struct EstimatedIncomeEditView: View {
    var paymentPeriods = ["Weekly", "Biweekly", "Semimonthly", "Monthly"]
    //@State private var selectedPaymentPeriod : PaymentPeriod = .Weekly
    
    @State private var selectedPaymentPeriod = "Weekly"
    
    @State private var amountText : String = ""
    
    @State private var amount : Double = 0.00
    
    var formatter: NumberFormatter{
        let formatter = NumberFormatter()
        formatter.numberStyle = .currency
        return formatter
    }
    
    var body: some View {
        VStack{
        HStack{
            
            
            TextField("Amount of regular paycheck", value: $amount, formatter: formatter)
                .keyboardType(.decimalPad)
                
            
            //amount = Float(amountText) ?? 0.00
            
            
            
                Picker("Select payment period", selection: $selectedPaymentPeriod) {
                    ForEach(paymentPeriods, id: \.self){
                        Text($0)
                    }
                }
                
                
            
            
            
        }
            Button("Save") {
                print("save")
                
                //1. Check that the input is a valid float
                
                //2. Make sure that it id rounded to 2 decimals
                
                saveIncome(amount, selectedPaymentPeriod)
                
                //go to method that
            }
    }
    }
    
    
}

struct EstimatedIncomeEditView_Previews: PreviewProvider {
    static var previews: some View {
        EstimatedIncomeEditView()
    }
}

/*
enum PaymentPeriod: String, CaseIterable, Identifiable{
    var id: ObjectIdentifier
    
    case Weekly, Biweekly, Semimonthly, Monthly
}*/
