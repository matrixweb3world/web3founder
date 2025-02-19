import Foundation

class UserService {
    static let shared = UserService()
    
    func login(email: String, password: String, completion: @escaping (Result<User, Error>) -> Void) {
        // 模拟登录逻辑
        DispatchQueue.main.asyncAfter(deadline: .now() + 1) {
            completion(.success(User(id: "1", email: email, walletAddress: "0x123", createdAt: Date())))
        }
    }
} 