import SwiftUI

struct MarketStatsView: View {
    var body: some View {
        VStack(alignment: .leading, spacing: 10) {
            Text("SPOT Market Stats")
                .font(.headline)
            HStack {
                Text("Market Cap")
                Spacer()
                Text("$12.75B")
            }
            HStack {
                Text("Price-Earnings Ratio")
                Spacer()
                Text("N/A")
            }
            HStack {
                Text("Dividend Yield")
                Spacer()
                Text("N/A")
            }
        }
    }
} 