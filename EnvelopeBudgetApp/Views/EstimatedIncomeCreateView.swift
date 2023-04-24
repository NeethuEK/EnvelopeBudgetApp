//
//  EstimatedIncomeCreateView.swift
//  EnvelopeBudgetApp
//
//  Created by Neethu Kuruvilla on 1/9/23.
//

import SwiftUI

struct EstimatedIncomeCreateView: View {
    
    @Environment(\.managedObjectContext) var saver
    
    var paymentPeriods = ["Weekly", "Biweekly", "Semimonthly", "Monthly"]
    
    @State private var selectedPaymentPeriod = "Weekly"
    
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
            
                Picker("Select payment period", selection: $selectedPaymentPeriod) {
                    ForEach(paymentPeriods, id: \.self){
                        Text($0)
                    }
                }
            
            }
            Button("Save") {
                
                do{
                    
                    let roundedAmount = decimalRounding(amount)
                    
                    let monthlyAmount = try getMonthlyAmount(checkAmount: roundedAmount, paymentPeriod: selectedPaymentPeriod)
                    
                    if monthlyAmount != -1{
                        let paymentNumberRep = try getPaymentPeriodNumber(selectedPaymentPeriod)
                        
                        let income = Incomes(context: saver)
                         income.amount = roundedAmount
                         income.paymentPeriod = paymentNumberRep
                         income.monthlyAmount = monthlyAmount
                         income.iD = UUID()
                         
                         try? saver.save()
                        
                        
                    }
                    
                }catch{
                    print("Error in getting monthly amount. Payment Period: \(selectedPaymentPeriod)")
                    
                }
            }//button
        }
    }
}
/*
struct EstimatedIncomeCreateView_Previews: PreviewProvider {
    
    @State var test : Bool = false
    static var previews: some View {
        
        
        EstimatedIncomeCreateView(popToList: self.$test)
    }
}*/
