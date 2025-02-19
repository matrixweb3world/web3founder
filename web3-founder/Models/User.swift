import Foundation

struct User: Codable, Identifiable {
    let id: String
    let email: String
    let walletAddress: String
    let createdAt: Date
} 