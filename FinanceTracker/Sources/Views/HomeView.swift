import SwiftUI

struct HomeView: View {
    @EnvironmentObject var dataManager: DataManager
    @State private var showingAddTransaction = false
    
    var body: some View {
        NavigationView {
            ScrollView {
                VStack(spacing: 20) {
                    // Balance Summary Card
                    VStack {
                        Text("Current Balance")
                            .font(.subheadline)
                            .foregroundColor(.secondary)
                        Text(dataManager.totalBalance, format: .currency(code: "USD"))
                            .font(.system(size: 36, weight: .bold))
                            .padding(.vertical, 8)
                        
                        HStack {
                            VStack {
                                Text("Income")
                                    .font(.caption)
                                    .foregroundColor(.secondary)
                                Text(dataManager.monthlySummary().income, format: .currency(code: "USD"))
                                    .foregroundColor(.green)
                            }
                            .frame(maxWidth: .infinity)
                            
                            Divider()
                            
                            VStack {
                                Text("Expenses")
                                    .font(.caption)
                                    .foregroundColor(.secondary)
                                Text(dataManager.monthlySummary().expense, format: .currency(code: "USD"))
                                    .foregroundColor(.red)
                            }
                            .frame(maxWidth: .infinity)
                        }
                        .padding()
                    }
                    .padding()
                    .background(Color(.systemBackground))
                    .cornerRadius(12)
                    .shadow(radius: 3)
                    
                    // Recent Transactions
                    VStack(alignment: .leading) {
                        HStack {
                            Text("Recent Transactions")
                                .font(.headline)
                            Spacer()
                            NavigationLink("See All") {
                                TransactionListView()
                            }
                            .font(.subheadline)
                        }
                        
                        ForEach(dataManager.transactions.prefix(3)) { transaction in
                            TransactionRow(transaction: transaction)
                        }
                    }
                    .padding()
                }
                .padding()
            }
            .navigationTitle("Overview")
            .toolbar {
                ToolbarItem(placement: .primaryAction) {
                    Button {
                        showingAddTransaction = true
                    } label: {
                        Image(systemName: "plus.circle.fill")
                            .font(.title2)
                    }
                }
            }
            .sheet(isPresented: $showingAddTransaction) {
                AddTransactionView()
            }
        }
    }
}

struct TransactionRow: View {
    let transaction: Transaction
    
    var body: some View {
        HStack {
            Image(systemName: transaction.type == .income ? "arrow.down.circle.fill" : "arrow.up.circle.fill")
                .foregroundColor(transaction.type == .income ? .green : .red)
                .font(.title2)
            
            VStack(alignment: .leading) {
                Text(transaction.category)
                    .font(.headline)
                Text(transaction.date.formatted(date: .numeric, time: .omitted))
                    .font(.caption)
                    .foregroundColor(.secondary)
            }
            
            Spacer()
            
            Text(transaction.amount, format: .currency(code: "USD"))
                .fontWeight(.medium)
                .foregroundColor(transaction.type == .income ? .green : .primary)
        }
        .padding(.vertical, 8)
    }
}

struct HomeView_Previews: PreviewProvider {
    static var previews: some View {
        HomeView()
            .environmentObject(DataManager())
    }
}