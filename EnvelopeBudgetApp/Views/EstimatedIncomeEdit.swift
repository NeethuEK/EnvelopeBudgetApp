//
//  EstimatedIncomeEdit.swift
//  EnvelopeBudgetApp
//
//  Created by Neethu Kuruvilla on 6/20/23.
//


import SwiftUI
import CoreData

struct EstimatedIncomeEdit: View {
    
    @State var selectedIncome: FetchedResults<Incomes>.Element
    
    @Environment(\.managedObjectContext) var saver
    
    var paymentPeriods: [String]{
        let p = Int16(selectedIncome.paymentPeriod)
        return editPaymentPeriodWheel(p)
    }
    
    @State var selectedPaymentPeriod: String
    
    var body: some View {
        Color("BackgroundMint")
            .overlay(
                VStack{
                    HStack{
                        Text("Paycheck amount")
                            .foregroundColor(Color.init("TextColor"))
                        
                        
                        TextField("", value: $selectedIncome.amount, format: .currency(code: Locale.current.currency?.identifier ?? "USD"))
                            .keyboardType(.decimalPad)
                            .background(Color.white)
                            .textFieldStyle(.roundedBorder)
                    }
                        .padding(.bottom, 40.0)
        
                    Picker("Paycheck Period", selection: $selectedPaymentPeriod) {
                        ForEach(paymentPeriods, id: \.self){
                            Text($0)
                        }
                    }
                        .pickerStyle(.segmented)
                    
                    Button("Save") {
                        
                        if selectedIncome.hasChanges || selectedPaymentPeriod != paymentPeriods[0]{
                            do{
                                let newAmount = decimalRounding(selectedIncome.amount)
                                
                                let newMonthlyAmount = try getMonthlyAmount(checkAmount: newAmount, paymentPeriod: selectedPaymentPeriod)
                                
                                try selectedIncome.paymentPeriod = getPaymentPeriodNumber(selectedPaymentPeriod)
                                selectedIncome.amount = newAmount
                                selectedIncome.monthlyAmount = newMonthlyAmount
                                
                                try? saver.save()
                                
                                print("New Amount: \(selectedIncome.amount)")
                                print("NEW PAYMENT PERIOD: \(selectedIncome.paymentPeriod)")
                                print("NEW MONTHLY AMOUNT: \(selectedIncome.monthlyAmount)")
                                
                            }catch{
                                print("Error")
                            }
                        }
                    }
                    .padding()
                    .foregroundColor(.black)
                    .background(Color.mint)
                    .clipShape(Capsule())
                    .font(.subheadline)
                }
        )
    }
}

