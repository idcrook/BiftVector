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

//import Foundation

/// A library for bit vectors (also called bit arrays) 
///
/// ```swift
/// import BiftVector
/// let bv1 = ~BiftVector(size: 32)
/// let bv2 = BiftVector(uintVal: 557122642, size: 32)
/// let result = bv1 ^ bv2
/// let bv3 = BiftVector(hexString: "decafBAD")
///
/// if (result == bv3) {
///     print("We've succeeded! 😎")
/// }
///
/// var bv4 = BiftVector(textString: "Ain't no 🌞 when she's gone")
/// let bv5 = BiftVector(bitString: "01100001011101110110000101111001")
/// bv4[0..<32] = bv5
/// ```
public struct BiftVector {

    // Bit storage uses 64 bit words
    static public let N = 64
    public typealias Word = UInt64
    
    /// How many **bits** are in this
    fileprivate(set) public var size: Int = 0
    
    /// Location where bits are implemented / stores
    fileprivate(set) public var words: [Word]
    
    // A helper variable
    static fileprivate let allOnes = ~Word()


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
    public init (bitString: String ) {
        assert(bitString.count >= 0)

        self.size = bitString.count
        let n = BiftVector.bitCountToWordCount(self.size)

        words = [Word](repeating: 0, count: n)
        for (index, character) in bitString.enumerated() {
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
    public init (uintVal: UInt64, size: Int = BiftVector.N) {
        assert(size <= BiftVector.N && size > 0)

        var bitString = ""

        // get bits representation
        let bits = String(uintVal, radix: 2)
        let numberOfBits = bits.count

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
    public init (textString: String) {
        assert(textString.count >= 0 )

        var bitString = ""


        for byte in textString.utf8 {
            let byteBits = String(byte, radix: 2)
            let padding = String(repeating: "0", count: (8 - byteBits.count))

            bitString = bitString + padding + byteBits
        }

        self.init(bitString: bitString)
    }

    /// Initialize an object from hexadecimal string value
    ///
    /// - Parameter hexString: String containing hex digits used to initialize a new vector
    /// - Parameter size: Size of the new vector
    public init (hexString: String, size: Int) {
        assert(size > 0)
        assert(hexString.count >= 0 )

        // check for truncation
        let nibblesInBits = hexString.count * 4
        if (size < nibblesInBits) {
            debugPrint("string \(hexString) likely contains more implicit bits than size \(size)")
        }

        var bitString = ""

        for (_, character) in hexString.lowercased().enumerated() {
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
    public init (hexString: String, withSize size: Int) {
        assert(size > 0)
        assert(hexString.count >= 0 )

        self.init(hexString: hexString, size: size)
    }

    /// Convenience initializer
    ///
    /// - Parameter hexString: String containing hex digits used to initialize a new vector
    public init (hexString: String) {
        assert(hexString.count >= 0 )

        var size: Int = BiftVector.N   // default implicit BiftVector size
        let nibblesInBits = hexString.count * 4
        if nibblesInBits > size {
            size = nibblesInBits
        }

        self.init(hexString: hexString, size: size)
    }
    
    
    /// Get UInt8 (bytes) of the bits
    ///
    /// - Returns: An array of the bytes
    public func toUInt8Array() -> Array<UInt8> {
        let totalBytes = self.bitCountToOctetCount()
        
        // Since the bits are stored reversed from UInt8 order, use a reversed bitorder copy
        let bvBitString = self.description
        let bv = BiftVector(bitString: String(bvBitString.reversed()))
        
        var array: [UInt8] = Array<UInt8>()
        let _ = bv.words.withUnsafeBytes { (ptr) in
            for i in 0..<totalBytes {
                array.append(ptr[i])
            }
        }
        return array
    }
    
    /// Get UInt64 (64b words) of the bits
    ///
    /// - Returns: An array of the 64b words
    public func toUInt64Array() -> Array<UInt64> {
        let totalWords = BiftVector.bitCountToWordCount(size)
        
        // Since the bits are stored reversed from UInt8 order, use a reversed bitorder copy
        let bvBitString = self.description
        let bv = BiftVector(bitString: String(bvBitString.reversed()))
        
        var array: [UInt64] = Array<UInt64>()
        let _ = bv.words.withUnsafeBufferPointer { (ptr) in
            for i in 0..<totalWords {
                array.append(ptr[i])
            }
        }
        return array
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

    public subscript(i: Int) -> Bool {
        get { return isSet(i) }
        set { if newValue { set(i) } else { clear(i) } }
    }

    /*
     If the size is not a multiple of N, then we have to clear out the bits
     that we're not using, or bitwise operations between two differently sized
     BitSets will go wrong.
     */
    fileprivate mutating func clearUnusedBits() {
        words[words.count - 1] &= lastWordMask()
    }
    
    /* Returns a mask that has 1s for all bits that are in the last word. */
    private func lastWordMask() -> Word {
        let diff = words.count*BiftVector.N - size
        if diff > 0 {
            // Set the highest bit that's still valid.
            let mask = 1 << Word(BiftVector.N - 1 - diff)
            // Subtract 1 to turn it into a mask, and add the high bit back in.
            return BiftVector.Word(mask | (mask - 1))
        } else {
            return BiftVector.allOnes
        }
    }
    
    public func isSet(_ i: Int) -> Bool {
        let (j, m) = sliceIndexOf(i)
        //let hexWord = String(words[j], radix: 16)
        //let bitMask = String(m, radix: 16)
        //print(self)
        //debugPrint("isSet(\(i)) for word[\(j)] 0x\(hexWord) bitmask: 0x\(bitMask)")
        return (words[j] & m) != 0
    }
    
    private func bitCountToOctetCount() -> Int {
        let n = (size + (8-1)) / 8
        return n
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

    /// Takes a bit index and returns the word bit is contained in and bitmask for word
    ///
    /// - Parameter i: bit index
    /// - Returns: word index and mask inside that word
    private func sliceIndexOf(_ i: Int) -> (Int, Word) {
        assert(i >= 0)
        assert(i < size, "Bit index [\(i)] out of range of \(self.debugDescription)")
        let o = i / BiftVector.N
        let s = (size / BiftVector.N)
        let p = s - o

        let m = Word(i - o*BiftVector.N)
        let n = Word(size - s*BiftVector.N)
        let j = n - m - 1

        //debugPrint("\(i) o=\(o) p=\(p) m=\(m) n=\(n) j=\(j)")
        return (p, 1 << j)
    }

    static private func lookupHexNibbleBitstring(_ character: Character) -> String {
        assert("0123456789abcdef".contains(character))
        var nibble = "0000"

        let nibbleNumber = UInt8(String(character), radix: 16)
        if let number = nibbleNumber {
            let convertedToBits = String(number & 0xf, radix: 2)
            // A nibble is 4 bits in size
            let padding = String(repeating: "0", count: (4 - convertedToBits.count))
            nibble = padding + convertedToBits
        }

        //debugPrint("\(character) -> \(nibble)")
        return nibble
    }
}


// MARK: - Extensions, including on Built-in Types

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

extension String {
    /// Utility function for BiftVector to truncate bitString to a given length
    ///
    /// - Parameter to: New length of bitString
    mutating func truncateBitString(to size: Int) {
        guard size <= self.count else {
            return  // size greater than number of characters: no need to truncate
        }
        let bitStringEndIndex = self.endIndex
        let bitStringstartIndex = self.index(bitStringEndIndex, offsetBy: -size)
        let range = Range(uncheckedBounds: (lower: bitStringstartIndex, upper: bitStringEndIndex))
        self = String(self[range])
    }

}

// MARK: - Protocols

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
        //debugPrint(s)
        return s
    }
    
    public var debugDescription: String {
        let s = description
        let t = "BiftVector(bitString: \"\(s)\")"
        return t
    }
}

// MARK: Comparable


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

// MARK: Collection

extension BiftVector: Collection {
    // subscript() implemented in struct
    
    public var startIndex: Int {
        return 0
    }
    
    public var count: Int {
        return self.size
    }
    
    public var endIndex: Int {
        return self.size
    }
    
    public func index(after: Int) -> Int {
        return after+1
    }
}

// MARK: Bitwise operations

extension BiftVector: BitwiseOperations {
    public static var allZeros: BiftVector {
        return BiftVector(size: BiftVector.N)
    }
    
    static private func copyLargest(_ lhs: BiftVector, _ rhs: BiftVector) -> BiftVector {
        return (lhs.words.count > rhs.words.count) ? lhs : rhs
    }
    
    static public func | (lhs: BiftVector, rhs: BiftVector) -> BiftVector {
        var out = copyLargest(lhs, rhs)
        let n = [lhs.words.count, rhs.words.count].min()!
        for i in 0..<n {
            out.words[i] = lhs.words[i] | rhs.words[i]
        }
        return out
    }
    
    // Returns the intersection of bits set in the two arguments.
    static public func & (lhs: BiftVector, rhs: BiftVector) -> BiftVector {
        let return_size = (lhs.size > rhs.size) ? lhs.size : rhs.size
        var out = BiftVector(size: return_size)
        let n = [lhs.words.count, rhs.words.count].min()!
        for i in 0..<n {
            out.words[i] = lhs.words[i] & rhs.words[i]
        }
        return out
    }
    
    static public func ^ (lhs: BiftVector, rhs: BiftVector) -> BiftVector {
        var out = copyLargest(lhs, rhs)
        let n = [lhs.words.count, rhs.words.count].min()!
        for i in 0..<n {
            out.words[i] = lhs.words[i] ^ rhs.words[i]
        }
        return out
    }
    
    static prefix public func ~ (rhs: BiftVector) -> BiftVector {
        var out = BiftVector(size: rhs.size)
        for i in 0..<rhs.words.count {
            out.words[i] = ~rhs.words[i]
        }
        out.clearUnusedBits()
        return out
    }
    
}

