import PackageDescription

let package = Package(
    name: "Tentacle",
    dependencies: [
        .Package(url: "https://github.com/thoughtbot/Argo.git", versions: Version(4, 1, 2)..<Version(4, .max, .max)),
        .Package(url: "https://github.com/thoughtbot/Curry.git", majorVersion: 3),
        .Package(url: "https://github.com/ReactiveCocoa/ReactiveSwift.git", majorVersion: 1),
    ]
)
