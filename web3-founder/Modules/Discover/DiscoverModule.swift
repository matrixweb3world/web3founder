import SwiftUI

// 公开主视图用于在应用中挂载
public struct DiscoverModule {
    // 主视图入口
    public static var mainView: some View {
        NavigationView {
            DiscoverView()
        }
    }
}
