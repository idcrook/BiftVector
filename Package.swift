// swift-tools-version:5.1
import PackageDescription

let package = Package(
  name: "BiftVector",
  products: [
    .library(
      name: "BiftVector",
      targets: ["BiftVector"]),
  ],
  dependencies: [
  ],
  targets: [
    .target(
      name: "BiftVector",
      dependencies: []),
    .testTarget(
      name: "BiftVectorTests",
      dependencies: ["BiftVector"])
  ]
)
