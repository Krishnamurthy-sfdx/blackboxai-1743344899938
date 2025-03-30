import Foundation

class DataManager: ObservableObject {
    @Published var transactions: [Transaction] = Transaction.sampleData
    
    // Add new transaction
    func addTransaction(_ transaction: Transaction) {
        transactions.append(transaction)
    }
    
    // Delete transaction by ID
    func deleteTransaction(withId id: UUID) {
        transactions.removeAll { $0.id == id }
    }
    
    // Get transactions filtered by type
    func filteredTransactions(type: TransactionType? = nil) -> [Transaction] {
        if let type = type {
            return transactions.filter { $0.type == type }
        }
        return transactions
    }
    
    // Calculate total balance
    var totalBalance: Double {
        let income = transactions.filter { $0.type == .income }.reduce(0) { $0 + $1.amount }
        let expenses = transactions.filter { $0.type == .expense }.reduce(0) { $0 + $1.amount }
        return income - expenses
    }
    
    // Calculate monthly summary
    func monthlySummary() -> (income: Double, expense: Double) {
        let currentMonth = Calendar.current.component(.month, from: Date())
        let monthlyTransactions = transactions.filter {
            Calendar.current.component(.month, from: $0.date) == currentMonth
        }
        
        let income = monthlyTransactions.filter { $0.type == .income }.reduce(0) { $0 + $1.amount }
        let expense = monthlyTransactions.filter { $0.type == .expense }.reduce(0) { $0 + $1.amount }
        
        return (income, expense)
    }
}