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
        .executable(name: "CodingChallengeTool", targets: ["CodingChallengeTool"]),
        .library(name: "CodingChallenge", targets: ["CodingChallenge"]),
    ],
    dependencies: [
        .package(name: "Advent of Code", url: "https://github.com/danielctull/Advent-of-Code", .branch("main")),
        .package(url: "https://github.com/apple/swift-argument-parser.git", from: "0.3.1"),
    ],
    targets: [
        .target(
            name: "CodingChallenge",
            dependencies: [
                .product(name: "Advent", package: "Advent of Code"),
            ]),
        .target(
            name: "CodingChallengeTool",
            dependencies: [
                .product(name: "Advent", package: "Advent of Code"),
                .product(name: "ArgumentParser", package: "swift-argument-parser"),
                "CodingChallenge",
            ]),
        .testTarget(
            name: "CodingChallengeTests",
            dependencies: [
                .product(name: "Advent", package: "Advent of Code"),
                "CodingChallenge"
            ],
            resources: [
                .copy("Inputs")
            ]),
    ]
)
