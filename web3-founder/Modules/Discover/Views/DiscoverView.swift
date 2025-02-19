import SwiftUI


struct DiscoverView: View {
    var body: some View {
        ScrollView {
            VStack(alignment: .leading, spacing: 20) {
                StockPriceView()
                MySpotPositionView()
                MarketStatsView()
                ExpertAdviceView()
            }
            .padding()
            .navigationTitle("发现")
        }
    }
}
