//
//  ReallocationRow.swift
//  EnvelopeBudgetApp
//
//  Created by Neethu Kuruvilla on 7/16/24.
//

import SwiftUI

struct ReallocationRow: View {
    @ObservedObject var reallocationItem: FetchedResults<Reallocate>.Element
    
    var body: some View {
        HStack{
            let formattedAmount = String(format: "%.2f", reallocationItem.amount)
            let startEnv = reallocationItem.sourceEnvelope?.label ?? "error:Not Found"
            let endEnv = reallocationItem.destinationEnvelope?.label ?? "error:Not Found"
            VStack{
                Text("\(formattedAmount)")
                //TODO: To and From envelope
                
                Text("\(String(startEnv)) to \(String(endEnv)) ")
            }
            Spacer()
            
            if reallocationItem.date == nil{
                Text("Error: Date not found")
            }else{
                Text(reallocationItem.date!, style: .date)
            }
        }
        
    }
}

