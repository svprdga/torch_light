// swift-tools-version: 5.9
import PackageDescription

let package = Package(
    name: "torch_light",
    platforms: [
        .iOS("13.0")
    ],
    products: [
        .library(name: "torch-light", targets: ["torch_light"])
    ],
    dependencies: [
        .package(name: "FlutterFramework", path: "../FlutterFramework")
    ],
    targets: [
        .target(
            name: "torch_light",
            dependencies: [
                .product(name: "FlutterFramework", package: "FlutterFramework")
            ]
        )
    ]
)
