import SwiftUI


struct TradingView: View {
    var body: some View {
        ScrollView {
            VStack(alignment: .leading, spacing: 20) {
                ChartView(
                    buyPercentage: 0.7,
                    holdPercentage: 0.25,
                    sellPercentage: 0.05,
                    targetPrice: 117.25,
                    estimatedReturn: 65.20
                )
                StockPriceView()
                MySpotPositionView()
                MarketStatsView()
                ExpertAdviceView()
            }
            .padding()
            .navigationTitle("交易")
        }
    }
}
