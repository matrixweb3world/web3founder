import Foundation
import Combine

class ExpertAdviceService {
    static let shared = ExpertAdviceService()
    
    func fetchExpertAdvice() -> AnyPublisher<ExpertAdvice, Error> {
        // 模拟数据
        let mockData = ExpertAdvice(
            buyPercentage: 0.7,
            holdPercentage: 0.25,
            sellPercentage: 0.05,
            targetPrice: 117.25,
            estimatedReturn: 65.20
        )
        
        // 使用 Just 和 Delay 模拟网络请求
        return Just(mockData)
            .setFailureType(to: Error.self)
            .delay(for: .seconds(1), scheduler: DispatchQueue.main)
            .eraseToAnyPublisher()
    }
} 