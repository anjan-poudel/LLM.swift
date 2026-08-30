// swift-tools-version: 6.0
// (bumped from 5.9: SwiftPM 6 rejects 5.9-era macro target declarations)
import PackageDescription
import CompilerPluginSupport

let package = Package(
    name: "LLM",
    platforms: [
        .iOS(.v16),
        .macOS(.v13),
        .watchOS(.v9),
        .tvOS(.v16),
        .visionOS(.v1)
    ],
    products: [
        .library(
            name: "LLM",
            targets: ["LLM"]
        )
    ],
    dependencies: [
        .package(url: "https://github.com/apple/swift-testing.git", branch: "main")
    ],
    targets: [
        .binaryTarget(
            name: "llama",
            path: "binary/llama.xcframework"
        ),
        .target(
            name: "LlamaChat",
            dependencies: ["llama"],
            path: "Sources/LlamaChat",
            publicHeadersPath: "include",
            cxxSettings: [
                .headerSearchPath("vendor")
            ],
            linkerSettings: [
                .linkedLibrary("c++")
            ]
        ),
        .target(
            name: "LLM",
            dependencies: ["llama", "LlamaChat"],
            path: "Sources/LLM"
        ),
    ],
    swiftLanguageModes: [.v5],
    cxxLanguageStandard: .cxx17
)
