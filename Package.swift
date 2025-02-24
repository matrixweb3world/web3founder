// swift-tools-version: 5.5

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
        // 移除 SwiftUICharts 依赖
    ],
    targets: [
        .target(
            name: "Web3Founder",
            dependencies: [],
            path: "web3-founder"
        ),
        .testTarget(
            name: "Web3FounderTests",
            dependencies: ["Web3Founder"],
            path: "web3-founderTests"
        ),
    ]
)
