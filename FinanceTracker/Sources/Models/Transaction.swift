import Foundation

enum TransactionType: String, CaseIterable {
    case income = "Income"
    case expense = "Expense"
}

struct Transaction: Identifiable, Codable {
    let id: UUID
    var amount: Double
    var category: String
    var date: Date
    var note: String
    var type: TransactionType
    
    init(id: UUID = UUID(), 
         amount: Double, 
         category: String, 
         date: Date = Date(), 
         note: String = "", 
         type: TransactionType) {
        self.id = id
        self.amount = amount
        self.category = category
        self.date = date
        self.note = note
        self.type = type
    }
}

extension Transaction {
    static let sampleData: [Transaction] = [
        Transaction(amount: 1200, category: "Salary", type: .income),
        Transaction(amount: 4.99, category: "Coffee", type: .expense),
        Transaction(amount: 12.50, category: "Lunch", type: .expense),
        Transaction(amount: 45.00, category: "Groceries", type: .expense),
        Transaction(amount: 200, category: "Freelance", type: .income),
        Transaction(amount: 8.75, category: "Transport", type: .expense),
        Transaction(amount: 60.00, category: "Entertainment", type: .expense),
        Transaction(amount: 150, category: "Bonus", type: .income)
    ]
}