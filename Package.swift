// swift-tools-version: 6.4

import PackageDescription

let package = Package(
    name: "swift-version-serializer",
    platforms: [
        .macOS(.v27),
        .iOS(.v27),
        .tvOS(.v27),
        .watchOS(.v27),
        .visionOS(.v27),
    ],
    products: [
        .library(
            name: "Version Serializer",
            targets: ["Version Serializer"]
        ),
    ],
    dependencies: [
        .package(url: "https://github.com/swift-atoms/swift-version.git", branch: "main"),
        .package(url: "https://github.com/swift-atoms/swift-byte.git", branch: "main"),
        .package(url: "https://github.com/swift-atoms/swift-serializer.git", branch: "main"),
    ],
    targets: [
        .target(
            name: "Version Serializer",
            dependencies: [
                .product(name: "Version", package: "swift-version"),
                .product(name: "Byte", package: "swift-byte"),
                .product(name: "Serializer", package: "swift-serializer"),
            ]
        ),
        .testTarget(
            name: "Version Serializer Tests",
            dependencies: [
                .product(name: "Version", package: "swift-version"),
                .product(name: "Byte", package: "swift-byte"),
                .product(
                    name: "Byte Standard Library Integration",
                    package: "swift-byte"
                ),
                .product(name: "Serializer", package: "swift-serializer"),
            ]
        ),
    ],
    swiftLanguageModes: [.v6]
)

for target in package.targets where ![.system, .binary, .plugin, .macro].contains(target.type) {
    let ecosystem: [SwiftSetting] = [
        .strictMemorySafety(),
        .enableUpcomingFeature("ExistentialAny"),
        .enableUpcomingFeature("InternalImportsByDefault"),
        .enableUpcomingFeature("MemberImportVisibility"),
        .enableUpcomingFeature("NonisolatedNonsendingByDefault"),
        .enableExperimentalFeature("Lifetimes"),
        .enableUpcomingFeature("InferIsolatedConformances"),
    ]

    let package: [SwiftSetting] = []
    target.swiftSettings = (target.swiftSettings ?? []) + ecosystem + package
}
