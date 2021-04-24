// swift-tools-version:5.3

import PackageDescription

let package = Package(
    name: "Red-Badger-Coding-Challenge",
    platforms: [
        .iOS(.v14),
        .macOS(.v11),
        .tvOS(.v14),
        .watchOS(.v7),
    ],
    products: [
        .library(name: "Red-Badger-Coding-Challenge", targets: ["Red-Badger-Coding-Challenge"]),
    ],
    targets: [
        .target(name: "Red-Badger-Coding-Challenge"),
        .testTarget(name: "Red-Badger-Coding-ChallengeTests", dependencies: ["Red-Badger-Coding-Challenge"]),
    ]
)
