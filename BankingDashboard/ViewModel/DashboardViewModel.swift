import Foundation
import Combine

@MainActor
class DashboardViewModel: ObservableObject {
    @Published var config: DashboardConfig?
    @Published var isLoading: Bool = false
    @Published var errorMessage: String? = nil

    private let configFetcher = ConfigFetcher()
    

    func processTransfer(recipient: String, amount: Double) {
            guard var updatedConfig = config else { return }
            let newTransaction = Transaction(
                id: UUID(),
                amount: -amount,
                date: "Today",
                description: "To: \(recipient)"
            )
            updatedConfig.balance -= amount
            updatedConfig.transactions.insert(newTransaction, at: 0)
            
            self.config = updatedConfig
        }
    func fetchData() async {
        
        isLoading = true
        errorMessage = nil
       
        do {
            self.config = try await configFetcher.fetchConfig()
            isLoading = false
        } catch {
            isLoading = false
            errorMessage = "Error: \(error.localizedDescription)"
            print("Decoding error: \(error)")
  
        }
    }
}
