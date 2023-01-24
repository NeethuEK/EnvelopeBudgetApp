//
//  EstimatedIncomesView.swift
//  EnvelopeBudgetApp
//
//  Created by Neethu Kuruvilla on 10/27/22.
//

import SwiftUI

struct EstimatedIncomesView: View {
    @FetchRequest(sortDescriptors: []) var incomes: FetchedResults<Incomes>
    var formatter: NumberFormatter{
        let formatter = NumberFormatter()
        formatter.numberStyle = .currency
        return formatter
    }
    
    var body: some View {
        
        NavigationView {
            VStack{
                Text("Regular Incomes")
                    .font(.title)
                List(incomes) { income in
                    
                    VStack {
                        let MonthlypaycheckAmount = String(format: "%.2f", income.monthlyAmount)
                        
                        let roundedAmount = String(format: "%.2f", income.amount)
                        
                        Text("\(MonthlypaycheckAmount)")
                        
                        
                        
                        HStack {
                            //Text("\(roundedAmount)")
                                //.font(.caption)
                            
                            Text("\(getPaymentPeriod(income.paymentPeriod)) amount: \(roundedAmount)")
                                .font(.caption)
                        }
                    }
                    
                    //Text("")
                    
                    //
                }
                
                HStack{
                    Text("Total income")
                    let total = getTotalIncome(incomes)
                   
                    
                    let formatedValue = String(format: "%.2f", total)
                    Text("\(formatedValue)")
                    
                    
                }
                Text("Available income")
                
                NavigationLink {
                    EstimatedIncomeCreateView()
                } label: {
                    Image(systemName: "plus.circle.fill")
                        .tint(.green)
                }

                
            }
        }
    }
    
    func test(_ value: Double){
        print(value)
    }
}



struct EstimatedIncomesView_Previews: PreviewProvider {
    static var previews: some View {
        EstimatedIncomesView()
    }
}
