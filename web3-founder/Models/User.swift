import Foundation

// 重命名为AppUser以避免与Auth模块中的User冲突
struct AppUser: Codable, Identifiable {
    let id: String
    let email: String
    let walletAddress: String
    let createdAt: Date
}
