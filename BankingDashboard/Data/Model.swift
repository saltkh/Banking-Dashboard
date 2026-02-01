import Foundation

struct Transaction: Codable, Identifiable {
    var id = UUID()
    let amount: Double
    let date: String
    let description: String

    enum CodingKeys: String, CodingKey {
        case amount
        case date
        case description
    }
}

struct DashboardConfig: Codable {
    let showBalance: Bool
    var balance: Double
    var transactions: [Transaction]

    enum CodingKeys: String, CodingKey {
        case showBalance = "show_balance"
        case balance
        case transactions
    }
}
