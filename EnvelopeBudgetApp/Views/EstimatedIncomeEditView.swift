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
    
    @State var earning: FetchedResults<Incomes>.Element
    
    //@StateObject var money: Incomes
    
    var paymentPeriods = ["Weekly", "Biweekly", "Semimonthly", "Monthly"]
    
    //var income : FetchedResults<Incomes>.Element
    
    private var selectedPaymentPeriodValue: String{
        return getPaymentPeriod(earning.paymentPeriod)
    }
    
    @State private var selectedPaymentPeriod : String = ""
    
    //@ObservedObject var income: Incomes
    //@State private var amountText : String = ""
    
    //init(money: Incomes) {
        //_money = StateObject(wrappedValue: money)
    //}
    /*
    var amount : Double{
        let amount = money.amount
        return amount
    }*/
    
    var formatter: NumberFormatter{
        let formatter = NumberFormatter()
        formatter.numberStyle = .currency
        return formatter
    }
    
    init(income: FetchedResults<Incomes>.Element){
        earning = income
        if Int(earning.paymentPeriod) != nil{
            selectedPaymentPeriod = paymentPeriods[Int(earning.paymentPeriod) - 1]
        }
        
    }
    
    var body: some View {
        VStack{
            HStack{
            
                
                TextField("Amount of regular paycheck", value: $earning.amount, formatter: formatter)
                .keyboardType(.decimalPad)
                
                
            
            //amount = Float(amountText) ?? 0.00
            
                //selectedPaymentPeriod = self.selectedPaymentPeriodValue
                
            //setDefaultPaymentPeriod()
                
                Picker("Select payment period", selection: $selectedPaymentPeriod) {
                    List {
                        ForEach(paymentPeriods, id: \.self){ paymentPeriod in
                            
                                
                        }
                    }
                }.onAppear{
                    //selectedPaymentPeriod = paymentPeriods[Int(earning.paymentPeriod) - 1]
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
    
    func setDefaultPaymentPeriod(){
        selectedPaymentPeriod = paymentPeriods[Int(earning.paymentPeriod)]
    }
    
}

/*
struct EstimatedIncomeEditView_Previews: PreviewProvider {
    @FetchRequest(sortDescriptors: []) var incomes: FetchedResults<Incomes>
    
    
    //incomes = Incomes.fetchRequest()
    
    
    static var previews: some View {
        
        //incomes.fet
        EstimatedIncomeEditView(income: <#FetchedResults<Incomes>.Element#>)
        
        //Incomes.
    }
}*/

/*
enum PaymentPeriod: String, CaseIterable{
    var id: ObjectIdentifier
    
    case Weekly, Biweekly, Semimonthly, Monthly
}*/
/*
struct Previews_EstimatedIncomeEditView_Previews: PreviewProvider {
    static var previews: some View {
        /*@START_MENU_TOKEN@*/Text("Hello, World!")/*@END_MENU_TOKEN@*/
    }
}*/
