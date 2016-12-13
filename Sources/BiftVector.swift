/**
 *  BiftVector
 *
 *  Copyright (c) 2016 David Crook. Licensed under the MIT license, as follows:
 *
 *  Permission is hereby granted, free of charge, to any person obtaining a copy
 *  of this software and associated documentation files (the "Software"), to deal
 *  in the Software without restriction, including without limitation the rights
 *  to use, copy, modify, merge, publish, distribute, sublicense, and/or sell
 *  copies of the Software, and to permit persons to whom the Software is
 *  furnished to do so, subject to the following conditions:
 *
 *  The above copyright notice and this permission notice shall be included in all
 *  copies or substantial portions of the Software.
 *
 *  THE SOFTWARE IS PROVIDED "AS IS", WITHOUT WARRANTY OF ANY KIND, EXPRESS OR
 *  IMPLIED, INCLUDING BUT NOT LIMITED TO THE WARRANTIES OF MERCHANTABILITY,
 *  FITNESS FOR A PARTICULAR PURPOSE AND NONINFRINGEMENT. IN NO EVENT SHALL THE
 *  AUTHORS OR COPYRIGHT HOLDERS BE LIABLE FOR ANY CLAIM, DAMAGES OR OTHER
 *  LIABILITY, WHETHER IN AN ACTION OF CONTRACT, TORT OR OTHERWISE, ARISING FROM,
 *  OUT OF OR IN CONNECTION WITH THE SOFTWARE OR THE USE OR OTHER DEALINGS IN THE
 *  SOFTWARE.
 */


// API
//
// Accessing and setting bits / slices
//  - let bit_1_or_0 = bv[M]
//  - let sliceBv = bv[M:N]
//  - for bit in biftvec { print ("\(bit)") }
//
// Logical opertions
//  - bvr = bv1 ^ bv2     // Bitwise Logical XOR
//  - bvr = bv1 & bv2     // Bitwise Logical AND
//  - bvr = bv1 | bv2     // Bitwise Logical OR
//  - bvr = ~bv1          // Bitwise negation
//
// Type Casting
//  - let i = Int(bv)  // may return an array of Ints
//  - let u = UInt64(bv)  // may return an array of UInt64
//
// // Add advance operations tier 2
//

//import Foundation


public struct BiftVector {

    // How man bits are in this
    private(set) public var size: Int = 0

    // Bit storage uses words
    static fileprivate let N = 64
    public typealias Word = UInt64
    fileprivate(set) public var words: [Word]

    /// Create an object that can hold `size` bits
    ///
    /// - Parameter size: Number of bits. All bits are set to zero
    public init (size aSize: Int) {
        assert(aSize >= 0)

        // round up to nearest number of words
        let n = BiftVector.bitCountToWordCount(aSize)

        self.size = aSize
        self.words = [Word](repeating: 0, count: n)
    }

    /// Initialize an object from an arrary of bits
    ///
    /// - Parameter bitlist: Array containing values 0 or 1
    public init (bitlist: [Int] ) {
        assert(bitlist.count >= 0)

        self.size = bitlist.count
        let n = BiftVector.bitCountToWordCount(self.size)

        words = [Word](repeating: 0, count: n)
        for (index, value) in bitlist.enumerated() {
            //debugPrint ("index \(index + 1): \(value)")
            if value == 1 {
                set(index)
            } else {
                clear(index)
            }
        }
    }

    /// Initialize an object from a bit string
    ///
    /// - Parameter bitstring: String containing text characters 0 or 1
    init (bitString: String ) {
        assert(bitString.characters.count >= 0)

        self.size = bitString.characters.count
        let n = BiftVector.bitCountToWordCount(self.size)

        words = [Word](repeating: 0, count: n)
        for (index, character) in bitString.characters.enumerated() {
            //debugPrint ("index \(index + 1): \(character)")
            if character == "1" {
                set(index)
            } else {
                clear(index)
            }
        }
    }

    /// Initialize an object from an integer value
    ///
    /// - Parameter intVal: 64b integer used for initializing bit value
    init (uintVal: UInt64, size: Int = BiftVector.N) {
        assert(size <= BiftVector.N && size > 0)

        var bitString = ""

        // get bits representation
        let bits = String(uintVal, radix: 2)
        let numberOfBits = bits.characters.count

        debugPrint("\(uintVal) \(bits) \(numberOfBits)")
        if numberOfBits < size {
            let padding = String(repeating: "0", count: (size - numberOfBits))
            bitString = padding + bits
        } else {
            bitString = bits
            bitString.truncateBitString(to: size)
        }

        self.init(bitString: bitString)
    }

    /// Initialize an object from string value
    ///
    /// - Parameter textString: String containing characters to form bit vector. Assumes UTF-8 encoding.
    init (textString: String) {
        assert(textString.characters.count >= 0 )

        var bitString = ""


        for byte in textString.utf8 {
            let byteBits = String(byte, radix: 2)
            let padding = String(repeating: "0", count: (8 - byteBits.characters.count))

            bitString = bitString + padding + byteBits
        }

        self.init(bitString: bitString)
    }


    /// Initialize an object from hexadecimal string value
    ///
    /// - Parameter hexString: String containing hex digits used to initialize a new vector
    /// - Parameter size: Size of the new vector
    init (hexString: String, size: Int) {
        assert(size > 0)
        assert(hexString.characters.count >= 0 )

        // check for truncation
        let nibblesInBits = hexString.characters.count * 4
        if (size < nibblesInBits) {
            debugPrint("string \(hexString) likely contains more implicit bits than size \(size)")
        }

        var bitString = ""

        for (_, character) in hexString.lowercased().characters.enumerated() {
            let nibble = BiftVector.lookupHexNibbleBitstring(character)
            bitString = bitString + nibble
        }

        // truncate bitString to size
        bitString.truncateBitString(to: size)

        self.init(bitString: bitString)
    }

    /// Convenience initializer
    ///
    /// - Parameter hexString: String containing hex digits used to initialize a new vector
    /// - Parameter withSize: Number of bits for new vector to contain
    init (hexString: String, withSize size: Int) {
        assert(size > 0)
        assert(hexString.characters.count >= 0 )

        self.init(hexString: hexString, size: size)
    }

    /// Convenience initializer
    ///
    /// - Parameter hexString: String containing hex digits used to initialize a new vector
    init (hexString: String) {
        assert(hexString.characters.count >= 0 )

        var size: Int = BiftVector.N   // default implicit BiftVector size
        let nibblesInBits = hexString.characters.count * 4
        if nibblesInBits > size {
            size = nibblesInBits
        }

        self.init(hexString: hexString, size: size)
    }

    /// Set bit at index to 1
    ///
    /// - Parameter i: index of bit
    public mutating func set(_ i: Int) {
        let (j, m) = indexOf(i)
        words[j] |= m
    }

    /// Set bit at index to 0
    ///
    /// - Parameter i: index of bit
    public mutating func clear(_ i: Int) {
        let (j, m) = indexOf(i)
        words[j] &= ~m
    }

    //
    public subscript(i: Int) -> Bool {
        get { return isSet(i) }
        set { if newValue { set(i) } else { clear(i) } }
    }

    public func isSet(_ i: Int) -> Bool {
        let (j, m) = indexOf(i)
        return (words[j] & m) != 0
    }

    static private func bitCountToWordCount(_ size: Int) -> Int {
        let n = (size + (N-1)) / N

        return n
    }

    /// Takes a bit index and returns the word bit is contained in and bitmask for word
    ///
    /// - Parameter i: bit index
    /// - Returns: word index and mask inside that word
    private func indexOf(_ i: Int) -> (Int, Word) {
        assert(i >= 0)
        assert(i < size)
        let o = i / BiftVector.N
        let m = Word(i - o*BiftVector.N)
        return (o, 1 << m)
    }

    static private func lookupHexNibbleBitstring(_ character: Character) -> String {
        assert("0123456789abcdef".characters.contains(character))
        var nibble = "0000"

        let nibbleNumber = UInt8(String(character), radix: 16)
        if let number = nibbleNumber {
            let convertedToBits = String(number & 0xf, radix: 2)
            // A nibble is 4 bits in size
            let padding = String(repeating: "0", count: (4 - convertedToBits.characters.count))
            nibble = padding + convertedToBits
        }

        debugPrint("\(character) -> \(nibble)")

        return nibble
    }
}

// MARK: - Debugging

extension BiftVector.Word {
    /// Utility function for a word: bitstring representation
    ///
    /// - Parameter bits: Number of bits (default: 64)
    /// - Returns: Bits in little-endian order, LSB first.
    public func bitsToString(_ bits: Int = 64) -> String {
        var s = ""
        var n = self
        for _ in 1...bits {
            s += ((n & 1 == 1) ? "1" : "0")
            n >>= 1
        }
        return s
    }
}

extension BiftVector: CustomStringConvertible, CustomDebugStringConvertible {
    public var description: String {
        var s = ""
        var z = size
        for x in words {
            if z > BiftVector.N {
                z = z - BiftVector.N
                s += x.bitsToString()
            } else {
                s += x.bitsToString(z)
            }
        }
        debugPrint(s)
        return s
    }

    public var debugDescription: String {
        var s = description
        s += "\nsize = \(size)"
        return s
    }
}

// MARK: - Extensions, Built-in Types

extension String {
    /// Utility function for BiftVector to truncate bitString to a given length
    ///
    /// - Parameter to: New length of bitString
    mutating func truncateBitString(to size: Int) {
        guard size <= self.characters.count else {
            return  // size greater than number of characters: no need to truncate
        }
        let bitStringEndIndex = self.endIndex
        let bitStringstartIndex = self.index(bitStringEndIndex, offsetBy: -size)
        let range = Range(uncheckedBounds: (lower: bitStringstartIndex, upper: bitStringEndIndex))
        self = self[range]
    }

}

// MARK: - Protocols

extension BiftVector: Comparable {
    
    public static func == (lhs: BiftVector, rhs: BiftVector) -> Bool {
        // lazy way
        return lhs.debugDescription == rhs.debugDescription
    }

    public static func < (lhs: BiftVector, rhs: BiftVector) -> Bool {
        if lhs.size != rhs.size {
            return lhs.size < rhs.size
        } else {
            return lhs.description < rhs.description
        }
    }
}





