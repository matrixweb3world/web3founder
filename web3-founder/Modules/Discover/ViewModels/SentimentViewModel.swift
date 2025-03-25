import Combine
import Foundation
import SwiftUI

class SentimentViewModel: ObservableObject {
    @Published var analysis: SentimentAnalysis?
    @Published var aiInsights: [AIInsight] = []
    @Published var isLoading: Bool = false
    @Published var error: String? = nil

    private let sentimentService: SentimentServiceProtocol
    private var cancellables = Set<AnyCancellable>()

    init(sentimentService: SentimentServiceProtocol = SentimentService()) {
        self.sentimentService = sentimentService
    }

    func loadSentimentAnalysis() {
        isLoading = true
        error = nil

        sentimentService.fetchSentimentAnalysis()
            .receive(on: DispatchQueue.main)
            .sink(
                receiveCompletion: { [weak self] completion in
                    self?.isLoading = false
                    if case .failure(let error) = completion {
                        self?.error = error.localizedDescription
                    }
                },
                receiveValue: { [weak self] analysis in
                    self?.analysis = analysis
                }
            )
            .store(in: &cancellables)
    }

    func loadAIInsights() {
        sentimentService.fetchAIInsights()
            .receive(on: DispatchQueue.main)
            .sink(
                receiveCompletion: { [weak self] completion in
                    if case .failure(let error) = completion {
                        self?.error = error.localizedDescription
                    }
                },
                receiveValue: { [weak self] insights in
                    self?.aiInsights = insights
                }
            )
            .store(in: &cancellables)
    }

    // 初次加载时一次性加载所有数据
    func loadAllData() {
        loadSentimentAnalysis()
        loadAIInsights()
    }
}
