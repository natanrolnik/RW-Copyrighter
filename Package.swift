// swift-tools-version:5.0
// The swift-tools-version declares the minimum version of Swift required to build this package.

import PackageDescription

let package = Package(
    name: "RW-Copyrighter",
    dependencies: [
        .package(url: "https://github.com/JohnSundell/Files.git", from: "3.1.0"),
        .package(url: "https://github.com/kylef/Commander.git", from: "0.9.0")
    ],
    targets: [
        // Targets are the basic building blocks of a package. A target can define a module or a test suite.
        // Targets can depend on other targets in this package, and on products in packages which this package depends on.
        .target(
            name: "RW-Copyrighter",
            dependencies: ["Files", "Commander"]),
        .testTarget(
            name: "RW-CopyrighterTests",
            dependencies: ["RW-Copyrighter"]),
    ]
)
