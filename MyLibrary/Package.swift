// swift-tools-version: 5.10
// The swift-tools-version declares the minimum version of Swift required to build this package.

import PackageDescription

let package = Package(
    name: "Packages",
    platforms: [
        .iOS(.v16)
    ],
    products: [
        .library(
            name: "EnvironmentVariables",
            targets: ["EnvironmentVariables"]),
        .library(
            name: "NetworkProvider",
            targets: ["NetworkProvider"]),
        .library(
            name: "CoreStyles",
            targets: ["CoreStyles"]),
        .library(
            name: "Search",
            targets: ["Search"]),
        .library(
            name: "CitiesList",
            targets: ["CitiesList"]),
        .library(
            name: "WeatherDetails",
            targets: ["WeatherDetails"]),
        .library(
            name: "SharedModules",
            targets: ["SharedModules"]),
        .library(
            name: "CoreDataManager",
            targets: ["CoreDataManager"]),
        .library(
            name: "WeatherHistory",
            targets: ["WeatherHistory"]),

    ],
    targets: [
        .target(
            name: "EnvironmentVariables",
            dependencies: [],
            path: "EnvironmentVariables/Sources"
        ),
        .target(
            name: "NetworkProvider",
            dependencies: [
                "EnvironmentVariables"
            ],
            path: "NetworkProvider/Sources"
        ),
        .target(
            name: "CoreStyles",
            dependencies: [],
            path: "CoreStyles/Sources"
        ),
        .target(
            name: "Search",
            dependencies: [
                "CoreStyles"
            ],
            path: "Search/Sources"
        ),
        .target(
            name: "CitiesList",
            dependencies: [
                "CoreStyles",
                "Search",
                "SharedModules",
                "WeatherDetails",
                "CoreDataManager",
                "WeatherHistory"
            ],
            path: "CitiesList/Sources"
        ),
        .target(
            name: "WeatherDetails",
            dependencies: [
                "CoreStyles",
                "EnvironmentVariables",
                "NetworkProvider",
                "SharedModules",
                "CoreDataManager"
            ],
            path: "WeatherDetails/Sources"
        ),

        .target(
            name: "SharedModules",
            dependencies: [
            ],
            path: "SharedModules/Sources"
        ),
        .target(
            name: "CoreDataManager",
            dependencies: [
                "SharedModules"
            ],
            path: "CoreDataManager/Sources"
        ),
        .target(
            name: "WeatherHistory",
            dependencies: [
                "CoreStyles",
                "EnvironmentVariables",
                "NetworkProvider",
                "SharedModules",
                "CoreDataManager",
                "WeatherDetails"
            ],
            path: "WeatherHistory/Sources"
        ),

        
        .testTarget(
            name: "CitiesListTests",
            dependencies: [
                "CoreDataManager",
                "SharedModules",
                "CitiesList"
            ],
            path: "CitiesList/Tests"
        ),
    ]
)
