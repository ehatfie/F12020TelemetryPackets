// swift-tools-version:5.2
// The swift-tools-version declares the minimum version of Swift required to build this package.

import PackageDescription

let package = Package(
    name: "F12020TelemetryPackets",
    products: [
        // Products define the executables and libraries a package produces, and make them visible to other packages.
        .library(
            name: "F12020TelemetryPackets",
            targets: ["F12020TelemetryPackets"]),
    ],
    dependencies: [
        // Dependencies declare other packages that this package depends on.
        // .package(url: /* package url */, from: "1.0.0"),
        .package(url: "https://github.com/apple/swift-nio.git", from: "2.18.0"),
    ],
    targets: [
        // Targets are the basic building blocks of a package. A target can define a module or a test suite.
        // Targets can depend on other targets in this package, and on products in packages this package depends on.
        .target(
            name: "F12020TelemetryPackets",
            dependencies: [.product(name: "NIO", package: "swift-nio")]),
        .testTarget(
            name: "F12020TelemetryPacketsTests",
            dependencies: ["F12020TelemetryPackets"]),
    ]
)
