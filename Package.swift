// swift-tools-version:5.5
// The swift-tools-version declares the minimum version of Swift required to build this package.

import PackageDescription

let package = Package(
    name: "mint_logger",
    platforms: [
        // Add support for all platforms starting from a specific version.
        .iOS(.v14)
    ],
    products: [
        // Products define the executables and libraries a package produces, and make them visible to other packages.
        .library(
            name: "MintLogger",
            targets: ["MintLogger"]),
    ],
    dependencies: [
        // Dependencies declare other packages that this package depends on.
         .package(url: "https://github.com/kean/Pulse", from: "1.1.0"),
         .package(url: "https://github.com/apple/swift-log", from: "1.0.0"),
         .package(url: "https://github.com/gordontucker/FittedSheets", from: "2.0.0")
    ],
    targets: [
        // Targets are the basic building blocks of a package. A target can define a module or a test suite.
        // Targets can depend on other targets in this package, and on products in packages this package depends on.
        .target(
            name: "MintLogger",
            dependencies: [
                .product(name: "Logging", package: "swift-log"),
                .product(name: "Pulse", package: "Pulse"),
                .product(name: "PulseUI", package: "Pulse"),
                .product(name: "PulseCore", package: "Pulse"),
                .product(name: "FittedSheets", package: "FittedSheets")
            ]),
        .testTarget(
            name: "MintLoggerTests",
            dependencies: ["MintLogger"]),
    ]
)
