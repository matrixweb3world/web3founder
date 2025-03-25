import Combine
import Foundation

protocol SentimentServiceProtocol {
    func fetchSentimentAnalysis() -> AnyPublisher<SentimentAnalysis, Error>
    func fetchAIInsights() -> AnyPublisher<[AIInsight], Error>
}

class SentimentService: SentimentServiceProtocol {
    private let apiService: APIServiceProtocol

    init(apiService: APIServiceProtocol = APIService()) {
        self.apiService = apiService
    }

    func fetchSentimentAnalysis() -> AnyPublisher<SentimentAnalysis, Error> {
        // 在实际应用中，这里应该调用 API 获取数据
        // 为简化示例，使用模拟数据
        let mockAnalysis = SentimentAnalysis.mock

        return Just(mockAnalysis)
            .setFailureType(to: Error.self)
            .delay(for: .seconds(0.5), scheduler: DispatchQueue.main)  // 模拟网络延迟
            .eraseToAnyPublisher()
    }

    func fetchAIInsights() -> AnyPublisher<[AIInsight], Error> {
        // 在实际应用中，这里应该调用 API 获取数据
        let mockInsights = AIInsight.mockList()

        return Just(mockInsights)
            .setFailureType(to: Error.self)
            .delay(for: .seconds(0.7), scheduler: DispatchQueue.main)  // 模拟网络延迟
            .eraseToAnyPublisher()
    }
}
