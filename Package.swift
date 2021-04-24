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
    dependencies: [
        .package(name: "Advent of Code", url: "https://github.com/danielctull/Advent-of-Code", .branch("main")),
    ],
    targets: [
        .target(
            name: "CodingChallenge",
            dependencies: [
                .product(name: "Advent", package: "Advent of Code"),
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
