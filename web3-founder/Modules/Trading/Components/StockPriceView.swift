import SwiftUI

struct StockPriceView: View {
    var body: some View {
        VStack(alignment: .leading) {
            Text("$71.05")
                .font(.largeTitle)
                .bold()
            Text("+$2.17 (2.94%) Last close")
                .foregroundColor(.green)
        }
    }
} 