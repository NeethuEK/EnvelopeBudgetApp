//
//  ExpenseRow.swift
//  EnvelopeBudgetApp
//
//  Created by Neethu Kuruvilla on 8/28/23.
//

/*
ToDo:
 Showcase payee as well
 */

import SwiftUI

struct ExpenseRow: View {
    @Environment(\.managedObjectContext) private var viewContext
    
    @ObservedObject var expense: FetchedResults<Expense>.Element
    
    var body: some View {
        HStack {
            let formattedAmount = String(format: "%.2f", expense.amount)
            
            Text("\(formattedAmount)")

            Spacer()
            VStack{
                Text("\(expense.title ?? "")")
                
                if expense.dateOf == nil{
                    Text("Error: Date not found")
                }else{
                    Text(expense.dateOf!, style: .date)
                }
                if let test = expense.env{
                    Text(test.label ?? "Error: Envelope not found")
                        .frame(alignment: .top)
                }
                
                
            }
            
        }
    }
}

/*
struct ExpenseRow_Previews: PreviewProvider {
    static var previews: some View {
        ExpenseRow()
    }
}
*/
