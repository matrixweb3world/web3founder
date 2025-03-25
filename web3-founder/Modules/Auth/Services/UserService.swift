import Combine
import Foundation

// 用户数据模型
struct User: Identifiable, Codable {
    let id: String
    let email: String
    let username: String
    let profileImageURL: URL?

    // 用于创建模拟数据的便利初始化器
    static func mock() -> User {
        return User(
            id: UUID().uuidString,
            email: "user@example.com",
            username: "crypto_user",
            profileImageURL: URL(string: "https://example.com/avatar.jpg")
        )
    }
}

// 登录错误类型
enum AuthError: Error {
    case invalidCredentials
    case networkError
    case serverError
    case unknown

    var localizedDescription: String {
        switch self {
        case .invalidCredentials:
            return "邮箱或密码不正确"
        case .networkError:
            return "网络连接错误，请检查网络设置"
        case .serverError:
            return "服务器错误，请稍后再试"
        case .unknown:
            return "未知错误，请稍后再试"
        }
    }
}

class UserService {
    static let shared = UserService()

    private init() {}

    func login(
        email: String, password: String, completion: @escaping (Result<User, AuthError>) -> Void
    ) {
        // 模拟网络延迟
        DispatchQueue.main.asyncAfter(deadline: .now() + 1.0) {
            // 模拟认证逻辑
            if email.contains("@") && password.count >= 6 {
                completion(.success(User.mock()))
            } else {
                completion(.failure(.invalidCredentials))
            }
        }
    }

    func register(
        email: String, password: String, completion: @escaping (Result<User, AuthError>) -> Void
    ) {
        // 模拟网络延迟
        DispatchQueue.main.asyncAfter(deadline: .now() + 1.5) {
            // 模拟注册逻辑
            if email.contains("@") && password.count >= 6 {
                completion(.success(User.mock()))
            } else {
                completion(.failure(.invalidCredentials))
            }
        }
    }

    func logout() {
        // 登出逻辑
        print("用户已登出")
    }
}
