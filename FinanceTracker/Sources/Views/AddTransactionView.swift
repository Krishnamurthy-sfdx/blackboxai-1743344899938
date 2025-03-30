import SwiftUI

struct AddTransactionView: View {
    @EnvironmentObject var dataManager: DataManager
    @Environment(\.dismiss) var dismiss
    
    @State private var amount = ""
    @State private var selectedCategory = "Food"
    @State private var date = Date()
    @State private var note = ""
    @State private var transactionType: TransactionType = .expense
    
    let categories = ["Food", "Transport", "Bills", "Shopping", "Entertainment", "Salary", "Freelance", "Other"]
    
    var body: some View {
        NavigationView {
            Form {
                Section("Transaction Details") {
                    Picker("Type", selection: $transactionType) {
                        ForEach(TransactionType.allCases, id: \.self) { type in
                            Text(type.rawValue)
                        }
                    }
                    .pickerStyle(.segmented)
                    
                    TextField("Amount", text: $amount)
                        .keyboardType(.decimalPad)
                    
                    Picker("Category", selection: $selectedCategory) {
                        ForEach(categories, id: \.self) { category in
                            Text(category)
                        }
                    }
                    
                    DatePicker("Date", selection: $date, displayedComponents: .date)
                }
                
                Section("Notes") {
                    TextField("Optional note", text: $note)
                }
            }
            .navigationTitle("Add Transaction")
            .toolbar {
                ToolbarItem(placement: .cancellationAction) {
                    Button("Cancel") {
                        dismiss()
                    }
                }
                
                ToolbarItem(placement: .primaryAction) {
                    Button("Save") {
                        if let amountValue = Double(amount) {
                            let newTransaction = Transaction(
                                amount: amountValue,
                                category: selectedCategory,
                                date: date,
                                note: note,
                                type: transactionType
                            )
                            dataManager.addTransaction(newTransaction)
                            dismiss()
                        }
                    }
                    .disabled(amount.isEmpty)
                }
            }
        }
    }
}

struct AddTransactionView_Previews: PreviewProvider {
    static var previews: some View {
        AddTransactionView()
            .environmentObject(DataManager())
    }
}