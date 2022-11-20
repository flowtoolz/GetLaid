// swift-tools-version:5.7

import PackageDescription

let package = Package(
    name: "GetLaid",
    platforms: [.iOS(.v11), .tvOS(.v11), .macOS(.v10_13)],
    products: [
        .library(name: "GetLaid", targets: ["GetLaid"]),
    ],
    dependencies: [],
    targets: [
        .target(name: "GetLaid", dependencies: [])
    ]
)
