
# BiftVector [![CI Status](https://travis-ci.org/idcrook/BiftVector.svg?branch=master)](https://travis-ci.org/idcrook/BiftVector)
<!-- [![Version](https://img.shields.io/cocoapods/v/BiftVector.svg?style=flat)](http://cocoapods.org/pods/BiftVector) [![License](https://img.shields.io/cocoapods/l/BiftVector.svg?style=flat)](http://cocoapods.org/pods/BiftVector) [![Platform](https://img.shields.io/cocoapods/p/BiftVector.svg?style=flat)](http://cocoapods.org/pods/BiftVector) -->

A Swift package for bit vectors (also called bit arrays).

## Features
Support arbitrarily-sized bit vectors

## Goals
  - Support arbitrarily-sized bit vectors, and support flexible lengths
  - Be performant and memory efficient
  - Include full complement of functions and operators
  - Documented API
  - Cross-platform compatible (Linux, iOS, macOS, watchOS, tvOS)
  - Use continuous integration and TDD (Test Driven Development) practices

Also plan to include a CLI wrapper, as a demo application.

## Examples

```swift
let bv1 = BiftVector(size: 100)
let bv2 = ~bv1
let result = bv1 ^ bv2

let bvSlice = result[2..<32]
print ("Size of bvSlice = \(bvSlice.length)")
```



### Compatibility

 - Swift 3.0+, Xcode 8+
 - 64b platforms

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

### Cocoapods

TBD

### Related packages

Searching through CocoaPods, I noticed

 - Bit
 - Bitter
 - BitByteStream 

## How this was created

In macOS

```bash
mkdir BiftVector
cd BiftVector
git init .
swift package init --type library
swift package generate-xcodeproj
open BiftVector.xcodeproj
```

## Author

David Crook

## Attribution

Inspired by https://pypi.python.org/pypi/BitVector

Named as a portmanteau word of `Biffed` and `Swift` that sounds close to `Bit`, forming into Vector.

## License

This package is licensed under the [MIT License](LICENSE.txt).

