//
//  EstimatedIncomesView.swift
//  EnvelopeBudgetApp
//
//  Created by Neethu Kuruvilla on 10/27/22.
//

import SwiftUI

struct EstimatedIncomesView: View {
    @FetchRequest(sortDescriptors: []) var incomes: FetchedResults<Incomes>
    
    @Environment(\.managedObjectContext) var saver
    
    @State private var showingDeleteAlert = false
    
    @State private var incomeToDelete: FetchedResults<Incomes>.Element? = nil
    
    var formatter: NumberFormatter{
        let formatter = NumberFormatter()
        formatter.numberStyle = .currency
        return formatter
    }
    
    
    var body: some View {
        
        NavigationView {
            
            Color("BackgroundMint")
                .overlay(
                VStack{
                    Text("Regular Incomes")
                        .font(.title)
                    NavigationView {
                        List {
                            
                            ForEach(incomes){ income in
                                NavigationLink {
                                    //EstimatedIncomeEditView()
                                    EstimatedIncomeEditView(income: income)
                                } label: {
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
                                }
                                .swipeActions {
                                    Button("Delete",role: .destructive) {
                                        self.incomeToDelete = income
                                        showingDeleteAlert = true
                                    }
                                }.confirmationDialog(Text("Are you sure you want to delete this income"), isPresented: $showingDeleteAlert, titleVisibility: .visible) {
                                    Button("Delete",role: .destructive) {
                                        deleteIncome(incomeToDelete)
                                    }
                                    Button("Cancel", role: .cancel) {
                                        showingDeleteAlert = false
                                    }
                                }
                            }
                            //.onDelete(perform: delete)
                            
                        }//List
                        
                    }//Navigation View
                    
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
                    .isDetailLink(false)
                    

                    
                }
            )
        }
    }//body view
    
    
    
    func delete(at offsets: IndexSet){
        
        
        for index in offsets{
            let income = incomes[index]
            saver.delete(income)
        }
        do {
            try saver.save()
        }catch{
            print("Error trying to delete income")
        }
        
    }
    
    func deleteIncome(_ income: FetchedResults<Incomes>.Element?){
        
        guard let income else { return }
        
        saver.delete(income)
        do{
            try saver.save()
        } catch{
            print("Error when deleting income")
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
