// swift-tools-version:5.5

import PackageDescription

let package = Package(
    name: "GeosugjebagAPI",
    products: [
        .library(
            name: "GeosugjebagAPI",
            targets: [
                "GeosugjebagAPI"
            ]
        ),
    ],
    targets: [
        .target(
            name: "GeosugjebagAPI"
        ),
        .testTarget(
            name: "GeosugjebagAPITests",
            dependencies: [
                "GeosugjebagAPI"
            ]
        )
    ]
)
