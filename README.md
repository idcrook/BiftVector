# BiftVector

[![CI Status](https://travis-ci.org/idcrook/BiftVector.svg?branch=master)](https://travis-ci.org/idcrook/BiftVector)
<!-- [![Version](https://img.shields.io/cocoapods/v/BiftVector.svg?style=flat)](http://cocoapods.org/pods/BiftVector) [![License](https://img.shields.io/cocoapods/l/BiftVector.svg?style=flat)](http://cocoapods.org/pods/BiftVector) [![Platform](https://img.shields.io/cocoapods/p/BiftVector.svg?style=flat)](http://cocoapods.org/pods/BiftVector) -->

**This project has not yet had its initial release.**

# Introduction

BiftVector is a Swift package for bit vectors (also called bit arrays).

**This project has not yet had its initial release!** See [project kanban](https://github.com/idcrook/BiftVector/projects/1) for current progress. Take a quick look at [contribution guidelines](https://github.com/idcrook/BiftVector/blob/master/.github/CONTRIBUTING.md).

Refer to the [Documentation](http://idcrook.github.io/BiftVector/) for more.




# Examples

```swift
import BiftVector
let bv1 = ~BiftVector(size: 32)
let bv2 = BiftVector(hexString: "21350452")
let result = bv1 ^ bv2
let bv3 = BiftVector(hexString: "decafBAD")

if (result == bv3) {
    print("We've succeeded! 😎")
}
```

# Goals And Features

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

## Compatibility

 - Swift 3.0+, Xcode 8+
 - 64b platforms

# Installation

## Swift Package manager

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

## Cocoapods

not yet officially released

## Carthage

not yet officially released

### Usage

```swift
import BiftVector
```


#### Using REPL on macOS

Point `swift` to the built Framwork. Here's how, assuming a successful build in XCode:

``` bash
$ swift -F `ls -trd ~/Library/Developer/Xcode/DerivedData/BiftVector-* | tail -1`/Build/Products/Debug
Welcome to Apple Swift version 3.0.2 (swiftlang-800.0.63 clang-800.0.42.1). Type :help for assistance.
  1> import BiftVector
  2> let bv1 = BiftVector(hexString: "C0FFEE600DDECAFBAD")
bv1: BiftVector.BiftVector = {
  size = 72
  words = 2 values {
    [0] = 16092341889477902083
    [1] = 181
  }
}
  3> print (~bv1)
001111110000000000010001100111111111001000100001001101010000010001010010
```

The above loads the framework that XCode project builds.

#### Bringing up REPL using Swift PM

This is still not working "out of the box" in Swift 3.0.2 release (which came bundled with XCode 8.2)

<!-- Uncomment when this works on macOS and Linux -->
<!-- ``` bash -->
<!-- $ cd /path/to/checkout -->
<!-- $ swift build -->
<!-- $ swift -I.build/debug -L.build/debug -lBiftVector -->
<!-- Welcome to Apple Swift version 3.0.2 (swiftlang-800.0.63 clang-800.0.42.1). Type :help for assistance. -->
<!--   1> import BiftVector -->
<!-- ``` -->
<!-- -->

# Development

Uses `XCT*` Framework which are included in Xcode and Swift distributions.

To run test suite from command line:

```bash
swift test
```

This build the package source if needed, and runs the test suite, reporting on any failures encounter.  The project embraces TDD (Test-Driven Development) which means all tests are required to pass.



# Credits

## Author(s)

David Crook - [@idcrook](https://github.com/idcrook)

## How this library was created

In macOS

```bash
mkdir BiftVector
cd BiftVector
git init .
swift package init --type library
swift package generate-xcodeproj
open BiftVector.xcodeproj
```
Later used SwiftPlate project output as guide https://github.com/JohnSundell/SwiftPlate


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

# License

This package is licensed under the [MIT License](LICENSE).
