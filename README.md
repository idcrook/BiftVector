BiftVector
==========

[![CI Status](https://travis-ci.org/idcrook/BiftVector.svg?branch=master)](https://travis-ci.org/idcrook/BiftVector) <!-- [![Version](https://img.shields.io/cocoapods/v/BiftVector.svg?style=flat)](http://cocoapods.org/pods/BiftVector) [![License](https://img.shields.io/cocoapods/l/BiftVector.svg?style=flat)](http://cocoapods.org/pods/BiftVector) [![Platform](https://img.shields.io/cocoapods/p/BiftVector.svg?style=flat)](http://cocoapods.org/pods/BiftVector) -->

**This project has not yet had its initial release.**

Introduction
============

BiftVector is a Swift package for bit vectors (also called bit arrays).

**This project has not yet had its initial release!** See [project kanban](https://github.com/idcrook/BiftVector/projects/1) for current progress. Take a quick look at [contribution guidelines](https://github.com/idcrook/BiftVector/blob/master/.github/CONTRIBUTING.md).

Refer to the [Documentation](http://idcrook.github.io/BiftVector/) for more.

Examples
========

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

Goals And Features
==================

The [project wiki](https://github.com/idcrook/BiftVector/wiki) has additional features listed.

Main goals

-	Intends to support "arbitrarily-sized" bit vectors
-	Include full complement of functions and operators
-	Documented API
-	Use continuous integration and TDD (Test Driven Development) practices

Additional goals

-	Cross-platform compatible (Linux, iOS, macOS, watchOS, tvOS)
-	Be performant and memory efficient
-	Include a CLI wrapper as a demo application
-	Include a Swift Playground to as another demo

Compatibility
-------------

-	Swift 5.1, Xcode 11
-	64b platforms

Installation
============

Swift Package manager
---------------------

In `Package.swift`, add the following for `BiftVector`, then run `swift build`.

```swift
    dependencies: [
        .package(url: "https://github.com/idcrook/BiftVector.git",
                 from: "0.1.0")
    ]
```

### Usage

```swift
import BiftVector
```

#### Using REPL with Swift PM

```bash
$ swift package clean
$ swift build
$ swift test
$ swift run --repl
Launching Swift REPL with arguments: -I/Users/dpc/projects/xcode/Projects/BiftVector/.build/x86_64-apple-macosx/debug -L/Users/dpc/projects/xcode/Projects/BiftVector/.build/x86_64-apple-macosx/debug -lBiftVector__REPL
Welcome to Apple Swift version 5.1 (swiftlang-1100.0.270.13 clang-1100.0.33.7).
Type :help for assistance.

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

#### Using Playground on macOS

There is now a `BiftVectorPlayground.playground`

However, there are still some unresolved problems with build Framework/Library in the schemes. Have been able to get playground to work using following:

```bash
open BiftVector.xcworkspace
# Now build using BiftVector-macOS schemes-- Included .playground now works
```

Need a better, more idiomatic, less fiddly way.

Development
===========

Uses `XCT*` Framework which are included in Xcode and Swift distributions.

To run test suite from command line:

```bash
swift test
```

This builds the package source if needed, and runs the test suite, reporting on any failures encountered. The project embraces TDD (Test-Driven Development) which means all tests are required to pass.

Credits
=======

Author(s)
---------

David Crook - [@idcrook](https://github.com/idcrook)

How this library was created
----------------------------

In macOS

```bash
mkdir BiftVector
cd BiftVector
git init .
swift package init --type library
swift package generate-xcodeproj
open BiftVector.xcodeproj
```

Attribution
-----------

Inspired by open source projects:

-	[BitVector project](https://pypi.python.org/pypi/BitVector) (Python)
-	Swift Algorithm Club [Bit Set](https://github.com/raywenderlich/swift-algorithm-club/tree/master/Bit%20Set) (Swift)

Named as a portmanteau word of `Bit` and `Swift` (sounds like `Biffed`) forming into Vector.

### Related packages

Searching through CocoaPods, I noticed

-	Bit
-	Bitter
-	BitByteStream

There are some related Framework types, but all of them seem to be restricted to operating on single words (i.e., up to 64 bits)

License
=======

This package is licensed under the [MIT License](LICENSE).
