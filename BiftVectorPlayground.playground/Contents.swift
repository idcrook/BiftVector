//: Playground - noun: a place where people can play

// for this Framework to be found/loadable, open BiftVector.xcworkspace and build BiftVector-macOS scheme in XCode

import BiftVector

var str = "Hello, playground"

let bv1 = BiftVector(hexString: "0b0a0d0e", withSize: 32)
let bv2 = BiftVector(textString: "2145")
let bv3 = bv1 | bv2




