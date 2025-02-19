import SwiftUI
// 如果 AuthViewModel 在一个单独的模块中，请确保导入该模块
// import YourModuleName

@main
struct CryptoAppApp: App {
    @UIApplicationDelegateAdaptor(AppDelegate.self) var appDelegate
    
    var body: some Scene {
        WindowGroup {
            MainTabView()
                .environmentObject(AuthViewModel.shared)
        }
    }
}

struct MainTabView: View {
    var body: some View {
        TabView {
            DiscoverView()
                .tabItem { Label("发现", systemImage: "magnifyingglass") }
            
            TradingView()
                .tabItem { Label("交易", systemImage: "chart.line.uptrend.xyaxis") }
            
            MyAssetsView()
                .tabItem { Label("资产", systemImage: "wallet.pass") }
            
            MoreView()
                .tabItem { Label("更多", systemImage: "ellipsis") }
        }
    }
} 