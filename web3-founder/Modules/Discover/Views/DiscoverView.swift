import Combine
import Foundation
import SwiftUI

struct DiscoverView: View {
    @StateObject private var kolViewModel = KOLViewModel()
    @StateObject private var tweetViewModel = TweetViewModel()
    @StateObject private var sentimentViewModel = SentimentViewModel()

    var body: some View {
        ScrollView {
            VStack(spacing: 16) {
                // KOL 监控概览
                KOLSummaryView(
                    monitoringCount: kolViewModel.kols.count,
                    todayTweetsCount: tweetViewModel.todayTweetCount,
                    importantNoticesCount: tweetViewModel.importantNoticeCount
                )
                .padding(.horizontal)

                // 情感分析
                if let analysis = sentimentViewModel.analysis {
                    SentimentAnalysisView(
                        positivePercentage: analysis.positivePercentage,
                        neutralPercentage: analysis.neutralPercentage,
                        negativePercentage: analysis.negativePercentage
                    )
                    .padding(.horizontal)
                } else {
                    ProgressView("加载情感分析...")
                        .frame(height: 200)
                }

                // 最新推文
                LatestTweetsView(tweets: tweetViewModel.latestTweets)
                    .padding(.horizontal)

                // AI 解读
                AIInsightView(
                    insights: sentimentViewModel.aiInsights,
                    onRefresh: {
                        sentimentViewModel.loadAIInsights()
                    }
                )
                .padding(.horizontal)
            }
            .padding(.vertical)
            .navigationTitle("KOL 监控中心")
            .onAppear {
                loadAllData()
            }
            // 添加下拉刷新
            .refreshable {
                loadAllData()
            }
        }
        .background(Color(.systemGray6).edgesIgnoringSafeArea(.all))
    }

    private func loadAllData() {
        kolViewModel.loadKOLs()
        tweetViewModel.loadAllData()
        sentimentViewModel.loadAllData()
    }
}

struct DiscoverView_Previews: PreviewProvider {
    static var previews: some View {
        Group {
            // 默认预览 (亮色模式)
            NavigationView {
                DiscoverView()
            }
            .previewDisplayName("亮色模式")

            // 暗色模式预览
            NavigationView {
                DiscoverView()
            }
            .preferredColorScheme(.dark)
            .previewDisplayName("暗色模式")

            // iPhone SE 预览
            NavigationView {
                DiscoverView()
            }
            .previewDevice("iPhone SE (3rd generation)")
            .previewDisplayName("iPhone SE")

            // iPad 预览
            NavigationView {
                DiscoverView()
            }
            .previewDevice("iPad Pro (11-inch) (4th generation)")
            .previewDisplayName("iPad Pro 11")
        }
    }
}
