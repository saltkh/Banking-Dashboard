import SwiftUI

struct TransactionRow: View {
    let transaction: Transaction

    var body: some View {
        HStack(spacing: 15) {
            Image(systemName: transaction.amount < 0 ? "arrow.up.right.circle.fill" : "arrow.down.left.circle.fill")
                .font(.system(size: 25))
                .foregroundColor(transaction.amount < 0 ? .red : .green)
            
            VStack(alignment: .leading) {
                Text(transaction.description)
                    .font(.body)
                    .fontWeight(.bold)
                    .fontDesign(.rounded)
                Text(transaction.date)
                    .font(.caption)
                    .foregroundColor(.gray)
            }
            
            Spacer()
            
            Text("$\(abs(transaction.amount), specifier: "%.2f")")
                .fontWeight(.semibold)
                .foregroundColor(transaction.amount < 0 ? .red : .green)
        }
        .padding()
    }
}
