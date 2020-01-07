// swift-tools-version:5.1

import PackageDescription

let package = Package(
    name: "GetLaid",
    products: [
        .library(name: "GetLaid",
                 targets: ["GetLaid"]),
    ],
    dependencies: [],
    targets: [
        .target(name: "GetLaid",
                dependencies: [],
                sources: ["Code/AllPlatforms",
                          "Code/AppKit",
                          "Code/UIKit"]),
    ]
)
