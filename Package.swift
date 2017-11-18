// swift-tools-version:4.0
import PackageDescription

let package = Package(
    name: "Tentacle",
    products: [
        .library(name: "Tentacle", targets: ["Tentacle"]),
    ],
    dependencies: [
        .package(url: "https://github.com/ReactiveCocoa/ReactiveSwift.git", from: "3.0.0"),
    ],
    targets: [
        .target(name: "Tentacle", dependencies: ["ReactiveSwift"]),
        .testTarget(name: "TentacleTests", dependencies: ["Tentacle"]),
    ],
    swiftLanguageVersions: [4]
)
