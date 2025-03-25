import Foundation
import SwiftUI

// 调整 SentimentType 映射到UI颜色
extension SentimentType {
    var viewColor: Color {
        switch self {
        case .positive:
            return .green
        case .neutral:
            return .yellow
        case .negative:
            return .red
        }
    }
}

struct LatestTweetsView: View {
    let tweets: [Tweet]

    var body: some View {
        VStack(alignment: .leading, spacing: 16) {
            Text("最新推文")
                .font(.headline)
                .padding(.horizontal)

            if tweets.isEmpty {
                Text("暂无推文")
                    .foregroundColor(.gray)
                    .frame(maxWidth: .infinity, alignment: .center)
                    .padding()
            } else {
                ForEach(tweets) { tweet in
                    TweetRowView(tweet: tweet)

                    if tweet.id != tweets.last?.id {
                        Divider()
                            .padding(.horizontal)
                    }
                }
            }
        }
        .padding(.vertical)
        .background(Color(.systemBackground))
        .cornerRadius(10)
        .shadow(radius: 2)
    }
}

struct TweetRowView: View {
    let tweet: Tweet

    var body: some View {
        VStack(alignment: .leading, spacing: 8) {
            HStack {
                Image(systemName: "person.circle")
                    .resizable()
                    .frame(width: 40, height: 40)
                    .foregroundColor(.gray)

                VStack(alignment: .leading) {
                    Text(tweet.authorUsername)
                        .font(.headline)

                    Text(tweet.timeAgo)
                        .font(.caption)
                        .foregroundColor(.gray)
                }

                Spacer()

                sentimentIcon
            }

            Text(tweet.content)
                .padding(.vertical, 4)

            HStack {
                ForEach(tweet.tags, id: \.self) { tag in
                    Text(tag)
                        .font(.caption)
                        .padding(.horizontal, 12)
                        .padding(.vertical, 4)
                        .background(tagBackground(for: tag))
                        .foregroundColor(.white)
                        .cornerRadius(12)
                }
            }
        }
        .padding(.horizontal)
    }

    private var sentimentIcon: some View {
        let iconName: String
        let color: Color

        switch tweet.sentiment {
        case .positive:
            iconName = "arrow.up.circle.fill"
            color = tweet.sentiment.viewColor
        case .neutral:
            iconName = "arrow.right.circle.fill"
            color = tweet.sentiment.viewColor
        case .negative:
            iconName = "arrow.down.circle.fill"
            color = tweet.sentiment.viewColor
        }

        return Image(systemName: iconName)
            .resizable()
            .frame(width: 16, height: 16)
            .foregroundColor(color)
    }

    private func tagBackground(for tag: String) -> Color {
        switch tag {
        case "positive", "积极":
            return .green
        case "neutral", "中性":
            return .yellow
        case "negative", "消极":
            return .red
        default:
            return .gray
        }
    }
}

// 预览
struct LatestTweetsView_Previews: PreviewProvider {
    static var previews: some View {
        // 创建符合新的Tweet模型的示例数据
        let mockTweets = [
            Tweet(
                id: "1",
                authorID: "crypto_analyst_id",
                authorUsername: "@crypto_analyst",
                content: "Bitcoin showing strong support at $40k. Bullish momentum building up! 🚀",
                publishedAt: Date().addingTimeInterval(-3600 * 5),
                timeAgo: "5小时前",
                sentiment: .positive,
                tags: ["positive", "加密货币"]
            ),
            Tweet(
                id: "2",
                authorID: "defi_expert_id",
                authorUsername: "@defi_expert",
                content:
                    "New DeFi protocol launched with innovative yield farming mechanism. Worth checking out! 🌾",
                publishedAt: Date().addingTimeInterval(-3600 * 2),
                timeAgo: "2小时前",
                sentiment: .neutral,
                tags: ["neutral", "DeFi"]
            ),
        ]

        return Group {
            LatestTweetsView(tweets: mockTweets)
                .previewLayout(.sizeThatFits)
                .padding()
                .previewDisplayName("有推文")

            LatestTweetsView(tweets: [])
                .previewLayout(.sizeThatFits)
                .padding()
                .previewDisplayName("无推文")
        }
    }
}
