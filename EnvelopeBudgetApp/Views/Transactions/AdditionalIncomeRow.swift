//
//  AdditionalIncomeRow.swift
//  EnvelopeBudgetApp
//
//  Created by Neethu Kuruvilla on 11/4/23.
//

import SwiftUI

struct AdditionalIncomeRow: View {
    @Environment(\.managedObjectContext) private var viewContext
    
    @ObservedObject var additonalIncome: FetchedResults<AdditionalIncome>.Element
    
    
    
    var body: some View {
        HStack {
            let formattedAmount = String(format: "%.2f", additonalIncome.amount)
            
            Text("\(formattedAmount)")

            Spacer()
            VStack{
                Text("\(additonalIncome.title ?? "")")
                
                if additonalIncome.dateOf == nil{
                    Text("Error: Date not found")
                }else{
                    Text(additonalIncome.dateOf!, style: .date)
                }
                if additonalIncome.willGoToEnvelope == true{
                    if let envelope = additonalIncome.env?.label{
                        Text(verbatim: envelope)
                    }
                }
                
                
            }
            
        }
    }
}
