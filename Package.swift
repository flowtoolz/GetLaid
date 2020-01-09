// swift-tools-version:5.1

import PackageDescription

let package = Package(
    name: "GetLaid",
    platforms: [.iOS(.v9), .tvOS(.v9), .macOS(.v10_11)],
    products: [
        .library(name: "GetLaid", targets: ["GetLaid"]),
    ],
    dependencies: [],
    targets: [
        .target(name: "GetLaid", dependencies: [])
    ]
)
