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
    @Environment(\.managedObjectContext) var saver
    
    @FetchRequest(sortDescriptors: [])var earning: FetchedResults<Incomes>
    
    @StateObject var money: Incomes
    
    var paymentPeriods = ["Weekly", "Biweekly", "Semimonthly", "Monthly"]
    
    //var income : FetchedResults<Incomes>.Element
    
    @State private var selectedPaymentPeriod = "Weekly"
    
    //@State private var amountText : String = ""
    
    init(money: Incomes) {
        _money = StateObject(wrappedValue: money)
    }
    
    var amount : Double{
        let amount = money.amount
        return amount
    }
    
    var formatter: NumberFormatter{
        let formatter = NumberFormatter()
        formatter.numberStyle = .currency
        return formatter
    }
    
    var body: some View {
        VStack{
            HStack{
            
                
                TextField("Amount of regular paycheck", value: $money.amount, formatter: formatter)
                .keyboardType(.decimalPad)
                
            
            //amount = Float(amountText) ?? 0.00
            
            
            
                Picker("Select payment period", selection: $money.paymentPeriod) {
                    ForEach(paymentPeriods, id: \.self){
                        Text($0)
                    }
                }
            
            }
            Button("Save") {
                
                //$money.paymentPeriod = selectedPaymentPeriod
                //get monthly amount
                
                
                let saveResult = saver.saveIfChanged()
                
                if saveResult != nil{
                    print("Error: \(saveResult.debugDescription)")
                }
                //1. Check that the input is a valid float
                
                //2. Make sure that it id rounded to 2 decimals
                
                //saveIncome(amount, selectedPaymentPeriod)
                
                //go to method that
            }
        }
    }
    
    
}

/*
struct EstimatedIncomeEditView_Previews: PreviewProvider {
    @FetchRequest(sortDescriptors: []) var incomes: FetchedResults<Incomes>
    
    //incomes = Incomes.fetchRequest()
    
    
    static var previews: some View {
        
        //incomes.fet
        //EstimatedIncomeEditView(money: Incomes.)
        
        //Incomes.
    }
}*/

/*
enum PaymentPeriod: String, CaseIterable, Identifiable{
    var id: ObjectIdentifier
    
    case Weekly, Biweekly, Semimonthly, Monthly
}*/
