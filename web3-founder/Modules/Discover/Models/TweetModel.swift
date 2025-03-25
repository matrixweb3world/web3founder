import Foundation

enum SentimentType: String, Codable {
    case positive, neutral, negative

    var color: String {
        switch self {
        case .positive:
            return "green"
        case .neutral:
            return "yellow"
        case .negative:
            return "red"
        }
    }
}

struct Tweet: Identifiable, Codable {
    let id: String
    let authorID: String
    let authorUsername: String
    let content: String
    let publishedAt: Date
    let timeAgo: String
    let sentiment: SentimentType
    let tags: [String]

    // 用于创建模拟数据的便利初始化器
    static func mock(id: String, author: String, content: String, sentiment: SentimentType) -> Tweet
    {
        Tweet(
            id: id,
            authorID: "author_\(id)",
            authorUsername: author,
            content: content,
            publishedAt: Date().addingTimeInterval(-Double.random(in: 0...86400)),  // 过去24小时内
            timeAgo: "\(Int.random(in: 1...24))小时前",
            sentiment: sentiment,
            tags: [sentiment.rawValue, "加密货币", "市场分析"].shuffled().prefix(2).map { $0 }
        )
    }
}
