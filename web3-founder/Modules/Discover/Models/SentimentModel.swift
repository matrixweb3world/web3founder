import Foundation

struct SentimentAnalysis: Codable {
    let positivePercentage: Double
    let neutralPercentage: Double
    let negativePercentage: Double

    // 用于创建模拟数据
    static var mock: SentimentAnalysis {
        let positive = Double.random(in: 0.5...0.8)
        let neutral = Double.random(in: 0.1...0.3)
        let negative = 1.0 - positive - neutral

        return SentimentAnalysis(
            positivePercentage: positive,
            neutralPercentage: neutral,
            negativePercentage: negative
        )
    }
}

struct AIInsight: Identifiable, Codable {
    let id: String
    let text: String

    // 用于创建模拟数据
    static func mockList() -> [AIInsight] {
        return [
            AIInsight(id: "1", text: "比特币价格表现强劲，投资者情绪普遍积极，预计短期内将保持上升趋势。"),
            AIInsight(id: "2", text: "市场对新的 DeFi 协议表现出浓厚兴趣，但投资者应该注意风险管理。"),
            AIInsight(id: "3", text: "根据当前市场情绪分析，建议保持适度乐观态度，分散投资组合。"),
        ]
    }
}
