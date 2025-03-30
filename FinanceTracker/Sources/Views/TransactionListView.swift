import SwiftUI

struct TransactionListView: View {
    @EnvironmentObject var dataManager: DataManager
    @State private var filter: TransactionType? = nil
    
    var body: some View {
        NavigationView {
            List {
                Picker("Filter", selection: $filter) {
                    Text("All").tag(TransactionType?.none)
                    ForEach(TransactionType.allCases, id: \.self) { type in
                        Text(type.rawValue).tag(Optional(type))
                    }
                }
                .pickerStyle(.segmented)
                .listRowSeparator(.hidden)
                .padding(.vertical)
                
                ForEach(dataManager.filteredTransactions(type: filter)) { transaction in
                    TransactionRow(transaction: transaction)
                        .swipeActions(edge: .trailing) {
                            Button(role: .destructive) {
                                dataManager.deleteTransaction(withId: transaction.id)
                            } label: {
                                Label("Delete", systemImage: "trash")
                            }
                        }
                }
            }
            .listStyle(.plain)
            .navigationTitle("Transactions")
            .toolbar {
                ToolbarItem(placement: .primaryAction) {
                    EditButton()
                }
            }
        }
    }
}

struct TransactionListView_Previews: PreviewProvider {
    static var previews: some View {
        TransactionListView()
            .environmentObject(DataManager())
    }
}