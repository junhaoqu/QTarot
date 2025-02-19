// swift-tools-version: 6.0

// WARNING:
// This file is automatically generated.
// Do not edit it by hand because the contents will be replaced.

import PackageDescription
import AppleProductTypes

let package = Package(
    name: "QTarot",
    platforms: [
        .iOS("16.0")
    ],
    products: [
        .iOSApplication(
            name: "QTarot",
            targets: ["AppModule"],
            bundleIdentifier: "com.JunhaoQu.QTarot",
            displayVersion: "1.0",
            bundleVersion: "1",
            appIcon: .placeholder(icon: .calendar),
            accentColor: .presetColor(.cyan),
            supportedDeviceFamilies: [
                .pad,
                .phone
            ],
            supportedInterfaceOrientations: [
                .portrait,
                .landscapeRight,
                .landscapeLeft,
                .portraitUpsideDown(.when(deviceFamilies: [.pad]))
            ],
            capabilities: [],
            additionalInfoPlistContentFilePath: nil
        )
    ],
    dependencies: [],
    targets: [
        .executableTarget(
            name: "AppModule",
            path: ".",
            resources: [
                .process("Assets.xcassets")
            ]
        )
    ],
    swiftLanguageVersions: [.version("6")]
)