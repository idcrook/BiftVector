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
// Constructor
//  - BiftVector(size: 0)
//  - BiftVector(bitlist: [1,0,1,0,0,1,0,1,0,0,1,0,1,0,0,1])
//  - BiftVector(bitstring: "1010010100101001")
//  - BiftVector(intVal: 8675309)
//  - BiftVector(intVal: 8675309, size: 24)
//  - BiftVector(textString: "hello")
//  - BiftVector(hexString: "decafBAD")
//  - bv2 = b1.copy()  // Copy constructor
//
//
// Display
//  - print(bv)
//  - let d = bv.description
//  - led dd = bv.debugDescription
//  - let i = Int(bv)  // may return an array of Ints
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
// BiftVector comparisons
//  - bv1 == bv2
//  - bv1 != bv2
//  - bv1 <  bv2
//  - bv1 <= bv2
//  - bv1 >  bv2
//  - bv1 >= bv2
//
// // Add advance operations tier 2
//

// import Foundation


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
            print ("index \(index + 1): \(value)")
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
    init (bitstring: String ) {
        assert(bitstring.characters.count >= 0)
        
        let n = BiftVector.bitCountToWordCount(self.size)
        
        words = [Word](repeating: 0, count: n)
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


    
    
    init (uintVal: UInt64, size: Int = 64 ) {
        assert(size >= 0)
        assert(uintVal < Word.max)

        words = [Word]()

    }

    init (textString: String ) {
        assert(textString.characters.count >= 0)

        words = [Word]()

    }
    
    init (hexString: String ) {
        assert(hexString.characters.count >= 0 )

        words = [Word]()

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
}

// MARK: - Debugging

extension UInt64 {
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

extension BiftVector: CustomStringConvertible {
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
        return s
    }
}

