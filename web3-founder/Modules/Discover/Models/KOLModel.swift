import Foundation

struct KOL: Identifiable, Codable {
    let id: String
    let username: String
    let displayName: String
    let avatarURL: URL?
    let followerCount: Int
    var isMonitored: Bool = false

    // 用于创建模拟数据的便利初始化器
    static func mock(id: String, username: String, displayName: String) -> KOL {
        KOL(
            id: id,
            username: username,
            displayName: displayName,
            avatarURL: URL(string: "https://example.com/avatar/\(id)"),
            followerCount: Int.random(in: 1000...100000),
            isMonitored: true
        )
    }
}
