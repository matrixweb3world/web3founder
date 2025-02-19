import SwiftUI

struct ExpertAdviceView: View {
    var body: some View {
        VStack(alignment: .leading, spacing: 10) {
            Text("What the Experts Say")
                .font(.headline)
            HStack {
                Text("70% Buy")
                Spacer()
                Text("25% Hold")
                Spacer()
                Text("5% Sell")
            }
            HStack {
                Text("Target Price")
                Spacer()
                Text("$117.25")
            }
            HStack {
                Text("Est Return")
                Spacer()
                Text("+65.20%")
            }
        }
    }
} 