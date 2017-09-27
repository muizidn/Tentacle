import PackageDescription

let package = Package(
    name: "Tentacle",
    dependencies: [
        .Package(url: "https://github.com/ReactiveCocoa/ReactiveSwift.git", majorVersion: 2),
    ],
    swiftLanguageVersions: [3, 4]
)
