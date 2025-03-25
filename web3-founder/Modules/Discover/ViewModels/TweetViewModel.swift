import Combine
import Foundation
import SwiftUI

class TweetViewModel: ObservableObject {
    @Published var latestTweets: [Tweet] = []
    @Published var todayTweetCount: Int = 0
    @Published var importantNoticeCount: Int = 0
    @Published var isLoading: Bool = false
    @Published var error: String? = nil

    private let tweetService: TweetServiceProtocol
    private var cancellables = Set<AnyCancellable>()

    init(tweetService: TweetServiceProtocol = TweetService()) {
        self.tweetService = tweetService
    }

    func loadLatestTweets() {
        isLoading = true
        error = nil

        tweetService.fetchLatestTweets()
            .receive(on: DispatchQueue.main)
            .sink(
                receiveCompletion: { [weak self] completion in
                    self?.isLoading = false
                    if case .failure(let error) = completion {
                        self?.error = error.localizedDescription
                    }
                },
                receiveValue: { [weak self] tweets in
                    self?.latestTweets = tweets
                }
            )
            .store(in: &cancellables)
    }

    func loadTweetsCount() {
        tweetService.fetchTweetsCount()
            .receive(on: DispatchQueue.main)
            .sink(
                receiveCompletion: { [weak self] completion in
                    if case .failure(let error) = completion {
                        self?.error = error.localizedDescription
                    }
                },
                receiveValue: { [weak self] count in
                    self?.todayTweetCount = count
                }
            )
            .store(in: &cancellables)
    }

    func loadImportantNoticesCount() {
        tweetService.fetchImportantNoticesCount()
            .receive(on: DispatchQueue.main)
            .sink(
                receiveCompletion: { [weak self] completion in
                    if case .failure(let error) = completion {
                        self?.error = error.localizedDescription
                    }
                },
                receiveValue: { [weak self] count in
                    self?.importantNoticeCount = count
                }
            )
            .store(in: &cancellables)
    }

    // 初次加载时一次性加载所有数据
    func loadAllData() {
        loadLatestTweets()
        loadTweetsCount()
        loadImportantNoticesCount()
    }
}
