
# BiftVector [![CI Status](https://travis-ci.org/idcrook/BiftVector.svg?branch=master)](https://travis-ci.org/idcrook/BiftVector)
<!-- [![Version](https://img.shields.io/cocoapods/v/BiftVector.svg?style=flat)](http://cocoapods.org/pods/BiftVector) [![License](https://img.shields.io/cocoapods/l/BiftVector.svg?style=flat)](http://cocoapods.org/pods/BiftVector) [![Platform](https://img.shields.io/cocoapods/p/BiftVector.svg?style=flat)](http://cocoapods.org/pods/BiftVector) -->

A Swift package for bit vectors (also called bit arrays).

**This project has not yet had its initial release.**

See [project kanban](https://github.com/idcrook/BiftVector/projects/1) for current progress. Take a quick look at [contribution guidelines](https://github.com/idcrook/BiftVector/blob/master/.github/CONTRIBUTING.md).

## Examples

More [examples here][examples].

```swift
let bv1 = ~BiftVector(size: 32)
let bv2 = BiftVector(hexString: "21350452")
let result = bv1 ^ bv2
let bv3 = BiftVector(hexString: "decafBAD")

if (result == bv3) {
    print("We've succeeded! 😎")
}
```


## Compatibility

 - Swift 3.0+, Xcode 8+
 - 64b platforms

## Goals and Features

The [project wiki](https://github.com/idcrook/BiftVector/wiki) has additional features listed.

Main goals
  - Intends to support "arbitrarily-sized" bit vectors
  - Include full complement of functions and operators
  - Documented API
  - Cross-platform compatible (Linux, iOS, macOS, watchOS, tvOS)
  - Use continuous integration and TDD (Test Driven Development) practices

Additional goals
  - Be performant and memory efficient
  - Include a CLI wrapper as a demo application
  - Include a Swift Playground to as another demo


## Setup


### Swift Package manager

In `Package.swift`, add the following for `BiftVector`, then run `swift build`.


```swift
import PackageDescription

let package = Package(
    name: "YourPackageName",
    targets: [],
    dependencies: [
        .Package(url: "https://github.com/idcrook/BiftVector.git",
                 versions: Version(0,1,0)..<Version(2,0,0))
    ]
)
```


#### Usage

```swift
import BiftVector
```

<!-- ##### Bringing up REPL using Swift PM -->
<!-- Uncomment when this works on macOS and Linux -->
<!-- ``` bash -->
<!-- $ cd /path/to/checkout -->
<!-- $ swift build -->
<!-- $ swift -I.build/debug -L.build/debug -lBiftVector -->
<!-- Welcome to Apple Swift version 3.0.2 (swiftlang-800.0.63 clang-800.0.42.1). Type :help for assistance. -->
<!--   1> import BiftVector -->
<!-- ``` -->
<!-- -->



### Cocoapods

TBD

## Development

Uses `XCT*` Framework which are included in Xcode and Swift distributions.

To run test suite from command line:
```bash
swift test
```

`swift test` runs `swift build` if needed, and works both under macOS and Linux.

## How this was created

In macOS

```bash
mkdir BiftVector
cd BiftVector
git init .
swift package init --type library
swift package generate-xcodeproj
open BiftVector.xcodeproj
# later used SwiftPlate project output as guide https://github.com/JohnSundell/SwiftPlate
```

## Author

David Crook - @idcrook

## Attribution

Inspired by open source projects:
  - [BitVector project](https://pypi.python.org/pypi/BitVector) (Python)
  - Swift Algorithm Club [Bit Set](https://github.com/raywenderlich/swift-algorithm-club/tree/master/Bit%20Set) (Swift)

Named as a portmanteau word of `Bit` and `Swift` (sounds like `Biffed`) forming into Vector.

### Related packages

Searching through CocoaPods, I noticed

 - Bit
 - Bitter
 - BitByteStream

There are some related Framework types, but all of them seem to be restricted to operating on single words (i.e., up to 64 bits)

## License

This package is licensed under the [MIT License](LICENSE.txt).

[examples]: https://github.com/idcrook/BiftVector/blob/master/EXAMPLES.md
