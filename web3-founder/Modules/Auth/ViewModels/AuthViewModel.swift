import Combine
import SwiftUI

class AuthViewModel: ObservableObject {
    // 创建单例实例
    static let shared = AuthViewModel()

    @Published var isAuthenticated = false
    @Published var isLoading = false
    @Published var errorMessage: String?

    private let authService = UserService.shared

    func login(email: String, password: String) {
        isLoading = true
        authService.login(email: email, password: password) { [weak self] result in
            self?.isLoading = false
            switch result {
            case .success(let user):
                self?.isAuthenticated = true
                print("Logged in user: \(user)")
            case .failure(let error):
                self?.errorMessage = error.localizedDescription
            }
        }
    }

    func register(email: String, password: String) {
        // 注册逻辑
    }
}
