import SwiftUI

struct BalanceCard: View {
    let balance: Double
    
    var body: some View {
        VStack(alignment:.leading, spacing: 20) {
            HStack {
                Text("Your Total Balance")
                    .font(.caption)
                    .fontWeight(.bold)
                    .textCase(.uppercase)
                Spacer()
                Image(systemName: "creditcard.fill") //
            }
            
            Text("$\(balance, specifier: "%.2f")")
                .font(.system(size: 40, weight: .bold))
            
            HStack {
                Text("**** 8821")
                Spacer()
                Text("VISA").italic().fontWeight(.black)
            }
            .font(.caption)
            .opacity(0.9)
        }
        .padding(26)
        .background(
            LinearGradient(
                colors: [
                    Color(red: 0.25, green: 0.63, blue: 1.0),
                    Color(red: 0.6, green: 0.85, blue: 1.0)
                ],
                startPoint: .topLeading,
                endPoint: .bottomTrailing
            )
        )
        
        .foregroundColor(.white)
        .cornerRadius(20)
        .padding(.horizontal)
    }
}

