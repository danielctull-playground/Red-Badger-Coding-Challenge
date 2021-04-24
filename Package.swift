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
        .library(name: "CodingChallenge", targets: ["CodingChallenge"]),
    ],
    targets: [
        .target(name: "CodingChallenge"),
        .testTarget(name: "CodingChallengeTests", dependencies: ["CodingChallenge"]),
    ]
)
