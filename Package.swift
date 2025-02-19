// swift-tools-version: 6.0

import PackageDescription

let package = Package(
    name: "Web3Founder",
    platforms: [
        .iOS(.v14)
    ],
    products: [
        .library(
            name: "Web3Founder",
            targets: ["Web3Founder"]),
    ],
    dependencies: [
        // 在这里添加您的依赖项，例如：
        // .package(url: "https://github.com/your-dependency.git", from: "1.0.0"),
        .package(url: "https://github.com/web3swift-team/web3swift.git", from: "3.0.0")
    ],
    targets: [
        .target(
            name: "Web3Founder",
            dependencies: [
                // 在这里添加您的目标依赖项，例如：
                // "YourDependency"
                "web3swift"
            ],
            path: "web3-founder"
        ),
        .testTarget(
            name: "Web3FounderTests",
            dependencies: ["Web3Founder"],
            path: "web3-founderTests"
        ),
    ]
)
