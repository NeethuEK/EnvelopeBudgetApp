//
//  EstimatedIncomesView.swift
//  EnvelopeBudgetApp
//
//  Created by Neethu Kuruvilla on 10/27/22.
//

import SwiftUI

struct EstimatedIncomesView: View {
    @FetchRequest(sortDescriptors: []) var incomes: FetchedResults<Incomes>
    
    @FetchRequest(sortDescriptors: []) var additionalIncomes: FetchedResults<AdditionalIncome>
    
    @FetchRequest(sortDescriptors: []) var Envelopes: FetchedResults<Envelope>
    
    @Environment(\.managedObjectContext) var saver
    
    @State private var showingDeleteAlert = false
    
    @State private var incomeToDelete: FetchedResults<Incomes>.Element? = nil
    
    
    var body: some View {
        
        NavigationView {
            
            Color("BackgroundMint")
                .overlay(
                VStack{
                    Text("Regular Incomes")
                        .font(.title)
                        .foregroundColor(Color.init("TextColor"))
                    NavigationView {
                        List {
                            
                            ForEach(incomes){ income in
                                NavigationLink {
                                    EstimatedIncomeEdit(selectedIncome: income, selectedPaymentPeriod: getPaymentPeriod(income.paymentPeriod))
                                } label: {
                                    VStack {
                                        let MonthlypaycheckAmount = String(format: "%.2f", income.monthlyAmount)
                                        
                                        let roundedAmount = String(format: "%.2f", income.amount)
                                        
                                        Text("\(MonthlypaycheckAmount)")
                                        
                                        
                                        
                                        HStack {
                                            
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
                                } //delete with confirmation message
                            }
            
                        }//List
                        
                    }//Navigation View
                    
                    HStack{
                        Text("Total income")
                            .foregroundColor(Color.init("TextColor"))
                        let total = getTotalIncome(incomes, additionalIncomes)
                       
                        
                        let formatedValue = String(format: "%.2f", total)
                        Text("\(formatedValue)")
                            
                        
                        
                    }
                    HStack{
                        Text("Available income: ")
                            .foregroundColor(Color.init("TextColor"))
                        let availableIncome = getAvailableAmount(incomes, additionalIncomes, Envelopes)
                            
                        
                        let formatedAvailableIncome = String(format: "%.2f", availableIncome)
                        Text( "\(formatedAvailableIncome)")
                    }
                  
                    
                    
                    NavigationLink {
                        EstimatedIncomeCreateView()
                    } label: {
                        Image(systemName: "plus.circle.fill")
                            .tint(.mint)
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
        } catch {
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
