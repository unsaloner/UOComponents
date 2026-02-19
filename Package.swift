// swift-tools-version: 5.9
import PackageDescription

let package = Package(
    name: "UOComponents",
    platforms: [
        .iOS(.v15)
    ],
    products: [
        .library(name: "UOComponents", targets: ["UOComponents"])
    ],
    dependencies: [
        .package(url: "https://github.com/SnapKit/SnapKit", from: "5.7.1")
    ],
    targets: [
        .target(
            name: "UOComponents",
            dependencies: ["SnapKit"],
            path: "Sources/UOComponents"
        )
    ]
)
