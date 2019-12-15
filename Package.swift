// swift-tools-version:5.1

import PackageDescription

let sourceDirectories: [String] = {
    #if os(OSX)
    return ["Code/AllPlatforms", "Code/AppKit"]
    #else
    return ["Code/AllPlatforms", "Code/UIKit"]
    #endif
}()

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
                sources: sourceDirectories),
    ]
)
