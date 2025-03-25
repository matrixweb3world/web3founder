import Combine
import Foundation

protocol KOLServiceProtocol {
    func fetchMonitoredKOLs() -> AnyPublisher<[KOL], Error>
    func toggleMonitoring(for kolID: String) -> AnyPublisher<Bool, Error>
}

class KOLService: KOLServiceProtocol {
    private let apiService: APIServiceProtocol

    init(apiService: APIServiceProtocol = APIService()) {
        self.apiService = apiService
    }

    func fetchMonitoredKOLs() -> AnyPublisher<[KOL], Error> {
        // 在实际应用中，这里应该调用 API 获取数据
        // 为简化示例，使用模拟数据
        let mockKOLs = [
            KOL.mock(id: "1", username: "@crypto_analyst", displayName: "Crypto Analyst"),
            KOL.mock(id: "2", username: "@defi_expert", displayName: "DeFi Expert"),
            KOL.mock(id: "3", username: "@nft_guru", displayName: "NFT Guru"),
            KOL.mock(id: "4", username: "@eth_developer", displayName: "ETH Developer"),
        ]

        return Just(mockKOLs)
            .setFailureType(to: Error.self)
            .delay(for: .seconds(0.5), scheduler: DispatchQueue.main)  // 模拟网络延迟
            .eraseToAnyPublisher()
    }

    func toggleMonitoring(for kolID: String) -> AnyPublisher<Bool, Error> {
        // 在实际应用中，这里应该调用 API 更新监控状态
        return Just(true)
            .setFailureType(to: Error.self)
            .delay(for: .seconds(0.3), scheduler: DispatchQueue.main)  // 模拟网络延迟
            .eraseToAnyPublisher()
    }
}
