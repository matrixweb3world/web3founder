import Combine
import Foundation
import SwiftUI

class KOLViewModel: ObservableObject {
    @Published var kols: [KOL] = []
    @Published var isLoading: Bool = false
    @Published var error: String? = nil

    private let kolService: KOLServiceProtocol
    private var cancellables = Set<AnyCancellable>()

    init(kolService: KOLServiceProtocol = KOLService()) {
        self.kolService = kolService
    }

    func loadKOLs() {
        isLoading = true
        error = nil

        kolService.fetchMonitoredKOLs()
            .receive(on: DispatchQueue.main)
            .sink(
                receiveCompletion: { [weak self] completion in
                    self?.isLoading = false
                    if case .failure(let error) = completion {
                        self?.error = error.localizedDescription
                    }
                },
                receiveValue: { [weak self] kols in
                    self?.kols = kols
                }
            )
            .store(in: &cancellables)
    }

    func toggleMonitoring(for kolID: String) {
        kolService.toggleMonitoring(for: kolID)
            .receive(on: DispatchQueue.main)
            .sink(
                receiveCompletion: { [weak self] completion in
                    if case .failure(let error) = completion {
                        self?.error = error.localizedDescription
                    }
                },
                receiveValue: { [weak self] success in
                    if success {
                        // 更新本地模型
                        if let index = self?.kols.firstIndex(where: { $0.id == kolID }) {
                            self?.kols[index].isMonitored.toggle()
                        }
                    }
                }
            )
            .store(in: &cancellables)
    }
}
