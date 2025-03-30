import SwiftUI

@main
struct FinanceTrackerApp: App {
    @StateObject private var dataManager = DataManager()
    
    var body: some Scene {
        WindowGroup {
            ContentView()
                .environmentObject(dataManager)
                .preferredColorScheme(.light) // Default to light mode
        }
    }
}