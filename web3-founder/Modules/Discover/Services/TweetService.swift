import Combine
import Foundation

protocol TweetServiceProtocol {
    func fetchLatestTweets() -> AnyPublisher<[Tweet], Error>
    func fetchTweetsCount() -> AnyPublisher<Int, Error>
    func fetchImportantNoticesCount() -> AnyPublisher<Int, Error>
}

class TweetService: TweetServiceProtocol {
    private let apiService: APIServiceProtocol

    init(apiService: APIServiceProtocol = APIService()) {
        self.apiService = apiService
    }

    func fetchLatestTweets() -> AnyPublisher<[Tweet], Error> {
        // 在实际应用中，这里应该调用 API 获取数据
        // 为简化示例，使用模拟数据
        let mockTweets = [
            Tweet.mock(
                id: "1",
                author: "@crypto_analyst",
                content: "Bitcoin showing strong support at $40k. Bullish momentum building up! 🚀",
                sentiment: .positive
            ),
            Tweet.mock(
                id: "2",
                author: "@defi_expert",
                content:
                    "New DeFi protocol launched with innovative yield farming mechanism. Worth checking out! 🌾",
                sentiment: .neutral
            ),
            Tweet.mock(
                id: "3",
                author: "@nft_guru",
                content:
                    "NFT market cooling down after recent hype. Time to be selective about projects.",
                sentiment: .negative
            ),
            Tweet.mock(
                id: "4",
                author: "@eth_developer",
                content:
                    "Ethereum L2 solutions continue to gain adoption. Gas fees significantly reduced for users. Great progress! 💯",
                sentiment: .positive
            ),
        ]

        return Just(mockTweets)
            .setFailureType(to: Error.self)
            .delay(for: .seconds(0.5), scheduler: DispatchQueue.main)  // 模拟网络延迟
            .eraseToAnyPublisher()
    }

    func fetchTweetsCount() -> AnyPublisher<Int, Error> {
        // 在实际应用中，这里应该调用 API 获取数据
        return Just(48)  // 模拟今日推文数
            .setFailureType(to: Error.self)
            .delay(for: .seconds(0.2), scheduler: DispatchQueue.main)
            .eraseToAnyPublisher()
    }

    func fetchImportantNoticesCount() -> AnyPublisher<Int, Error> {
        // 在实际应用中，这里应该调用 API 获取数据
        return Just(3)  // 模拟重要通知数
            .setFailureType(to: Error.self)
            .delay(for: .seconds(0.2), scheduler: DispatchQueue.main)
            .eraseToAnyPublisher()
    }
}
