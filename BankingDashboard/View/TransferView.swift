import SwiftUI

struct TransferView: View {
    @Environment(\.dismiss) var dismiss
    @ObservedObject var viewModel: DashboardViewModel
    @State private var recipientInfo: String = ""
    @State private var amount: String = ""
    @State private var showingError = false
    
    let contacts = ["Alex", "Jordan", "Taylor", "Casey", "Sam"]
    
    var body: some View {
        NavigationView {
            VStack(spacing: 30) {
                
                // 1. send section. shows recent contacts for fats transfer
                VStack(alignment: .leading) {
                    Text("Quick Transfer")
                        .font(.headline)
                        .padding(.horizontal)
                    
                    ScrollView(.horizontal, showsIndicators: false) {
                        HStack(spacing: 20) {
                            // add new button for new person
                            VStack {
                                Image(systemName: "plus.circle.fill")
                                    .resizable()
                                    .frame(width: 60, height: 60)
                                    .foregroundColor(.blue)
                                Text("Add")
                                    .font(.caption)
                            }
                            //show each person
                            ForEach(contacts, id: \.self) { name in
                                VStack {
                                    Image(systemName: "person.crop.circle.fill")
                                        .resizable()
                                        .frame(width: 60, height: 60)
                                        .foregroundColor(.gray.opacity(0.3))
                                    Text(name)
                                        .font(.caption)
                                }
                            }
                        }
                        .padding(.horizontal)
                    }
                }
                .padding(.top)

                // 2. input section
                VStack(spacing: 15) {
                    TextField("Input ID, Card, Phone Number", text: $recipientInfo)
                        .padding()
                        .background(Color(.secondarySystemBackground))
                        .cornerRadius(12)
                        .keyboardType(.numbersAndPunctuation)
                    
                    TextField("Amount ($0.00)", text: $amount)
                        .padding()
                        .background(Color(.secondarySystemBackground))
                        .cornerRadius(12)
                        .keyboardType(.decimalPad)
                }
                .padding(.horizontal)

                Spacer()

                // 3. action button
                VStack(spacing: 12) {
                    Button(action: {
                        // Check if amount is enough
                        if let transferAmount = Double(amount), !recipientInfo.isEmpty {
                            if transferAmount <= (viewModel.config?.balance ?? 0) {
                                viewModel.processTransfer(recipient: recipientInfo, amount: transferAmount)
                                dismiss()
                            } else {
                                showingError = true
                            }
                        }
                    }) {
                        Text("Send Money")
                            .fontWeight(.bold)
                            .frame(maxWidth: .infinity)
                            .padding()
                            .background((recipientInfo.isEmpty || amount.isEmpty) ? Color.gray : Color.blue)
                            .foregroundColor(.white)
                            .cornerRadius(20)
                    }
                    .disabled(recipientInfo.isEmpty || amount.isEmpty)

                    Button("Cancel") {
                        dismiss() // go back,dont do anything
                    }
                    .foregroundColor(.red)
                    .padding(.top, 8)
                }
                .padding(.horizontal)
                .padding(.bottom, 20)
                .alert("Insufficient Funds", isPresented: $showingError) {
                    Button("OK", role: .cancel) { }
                } message: {
                    Text("You don't have enough money in your account.")
                }
            }
            .navigationTitle("Transfer")
            .navigationBarTitleDisplayMode(.inline)
        }
    }
}




