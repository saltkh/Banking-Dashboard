import SwiftUI

struct DashboardView: View {
    @StateObject private var viewModel = DashboardViewModel()
    @State private var showingTransfer = false

    var body: some View {
        NavigationView {
            ZStack {
                if viewModel.isLoading {
                    ProgressView("Updating . . .")
                } else if let errorMessage = viewModel.errorMessage {
                    VStack(spacing: 25) {
                        Text(errorMessage).multilineTextAlignment(.center)
                        Button("Try Again") {
                            Task { await viewModel.fetchData() }
                        }
                        .buttonStyle(.borderedProminent)
                    }
                    .padding()
                } else if let config = viewModel.config {
                    ScrollView {
                        VStack(spacing: 0) {
                            if config.showBalance {
                                BalanceCard(balance: config.balance)
                                    .padding(.bottom, 20)
                                    .padding(.top, -60)
                            }

                            // transfer button
                            Button(action: { showingTransfer.toggle() }) {
                                HStack {
                                    Image(systemName: "paperplane.fill")
//                                    Spacer()
                                    Text("Quick Transfer")
                                        .fontWeight(.semibold)
                                }
                                .frame(maxWidth: .infinity)
                                .padding()
                                .background(Color.blue.opacity(0.1))
                                .foregroundColor(.blue)
                                .cornerRadius(12)
                                .padding(.horizontal)
                            }
                            .padding(.bottom, 20)

                            // transaction list 
                            VStack(alignment: .leading, spacing: 15) {
                                Text("Recent Transactions")
                                    .font(.headline)
                                    .padding(.horizontal)

                                VStack(spacing: 0) {
                                    ForEach(config.transactions) { item in
                                        TransactionRow(transaction: item)
                                        if item.id != config.transactions.last?.id {
                                            Divider().padding(.leading, 60)
                                        }
                                    }
                                }
                                .background(Color(.secondarySystemBackground))
                                .cornerRadius(20)
                                .padding(.horizontal)
                            }
                        }
                        .padding(.vertical)
                    }
                }
            }
            .navigationTitle("Welcome")
            .sheet(isPresented: $showingTransfer) {
                TransferView(viewModel: viewModel)
            }
            .task {
                await viewModel.fetchData()
            }
        }
    }
}






