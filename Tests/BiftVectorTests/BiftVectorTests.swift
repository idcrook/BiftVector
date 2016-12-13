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
import XCTest
@testable import BiftVector

class BiftVectorTests: XCTestCase {

    override func setUp() {
        super.setUp()
    }

    func testInit_AcceptsSizeZero() {
        let bv = BiftVector(size: 0)
        XCTAssertEqual(bv.description, "")
    }

    func testInit_AcceptsSizeLessThan64() {
        let bv = BiftVector(size: 33)
        XCTAssertEqual(bv.description, "000000000000000000000000000000000")
    }

    func testInit_AcceptsSizeGreaterThan64() {
        let bv = BiftVector(size: 65)
        XCTAssertEqual(bv.description, "00000000000000000000000000000000000000000000000000000000000000000")
    }

    func testDebugExtension_descriptionSizeOf1() {
        let bv = BiftVector(size: 1)
        XCTAssertEqual(bv.description, "0")
    }

    func testDebugDescriptionExtension_descriptionSizeOf1() {
        let bv = BiftVector(size: 1)
        XCTAssertEqual(bv.debugDescription, "BiftVector(bitString: \"0\") // size = 1")
    }

    func testDebugExtension_descriptionSizeOf63() {
        let bv = BiftVector(size: 63)
        XCTAssertEqual(bv.description, "000000000000000000000000000000000000000000000000000000000000000")
    }

    func testDebugExtension_descriptionSizeOf64() {
        let bv = BiftVector(size: 64)
        XCTAssertEqual(bv.description, "0000000000000000000000000000000000000000000000000000000000000000")
    }

    func testInit_AcceptsBitlist() {
        let bv = BiftVector(bitlist: [1,1,1,1,1,1,1,0])
        XCTAssertEqual(bv.description, "11111110")
    }

    func testInit_AcceptsBitstring() {
        let bv = BiftVector(bitString: "11111111011111111")
        XCTAssertEqual(bv.description, "11111111011111111")
    }

    func testInit_ShouldTakeUIntValue() {
        let bv = BiftVector(uintVal: 8675309)
        XCTAssertEqual(bv.description, "0000000000000000000000000000000000000000100001000101111111101101")
    }

    func testInit_ShouldTakeUIntValueWithSize() {
        let bv = BiftVector(uintVal: 8675309, size: 24)
        XCTAssertEqual(bv.description,  "100001000101111111101101")
    }

    func testInit_ShouldTakeUIntValue2WithSize() {
        let bv = BiftVector(uintVal: 8675309, size: 25)
        XCTAssertEqual(bv.description, "0100001000101111111101101")
    }

    func testInit_AcceptsHexStringImplicitSize() {
        let bv = BiftVector(hexString: "deadBEEF")
        XCTAssertEqual(bv.description, "11011110101011011011111011101111")
    }

    func testInit_AcceptsHexStringImplicitSize2() {
        let bv = BiftVector(hexString: "0deadBEEF")
        XCTAssertEqual(bv.description, "000011011110101011011011111011101111")
    }

    func testInit_AcceptsHexStringLargeImplicitSize() {
        let bv = BiftVector(hexString: "decafBADc0ffee600D")
        XCTAssertEqual(bv.description, "110111101100101011111011101011011100000011111111111011100110000000001101")
    }

    func testInit_AcceptsHexStringExplicitSize() {
        let bv = BiftVector(hexString: "7A", withSize: 7)
        XCTAssertEqual(bv.description, "1111010")
    }

    func testInit_AcceptsTextString() {
        let bv = BiftVector(textString: "7A")
        XCTAssertEqual(bv.description, "0011011101000001")
    }

    func testInit_AcceptsEmptyTextString() {
        let bv = BiftVector(textString: "")
        XCTAssertEqual(bv.description, "")
    }

    func testInit_AcceptsNonAsciiString() {
        let bv = BiftVector(textString: "🖖")
        XCTAssertEqual(bv.description, "11110000100111111001011010010110")
    }

    func testEquatable_EqualTo() {
        let bv1 = BiftVector(hexString: "deadBEEF")
        let bv2 = BiftVector(hexString: "deadBEEF")
        XCTAssertTrue(bv1 == bv2)
    }

    func testEquatable_EqualTo2() {
        let bv1 = BiftVector(uintVal: 126, size: 7)
        let bv2 = BiftVector(hexString: "fe", withSize: 7)
        XCTAssertTrue(bv1 == bv2)
    }

    func testEquatable_NotEqualTo() {
        let bv1 = BiftVector(hexString: "deadBEEF")
        let bv2 = BiftVector(hexString: "decafbad")
        XCTAssertTrue(bv1 != bv2)
    }

    func testEquatable_NotEqualTo2() {
        let bv1 = BiftVector(uintVal: 127, size: 7)
        let bv2 = BiftVector(uintVal: 127, size: 8)
        XCTAssertTrue(bv1 != bv2)
    }

    func testComparable_LessThan() {
        let bv1 = BiftVector(uintVal: 127, size: 7)
        let bv2 = BiftVector(uintVal: 127, size: 8)
        XCTAssertTrue(bv1 < bv2)
    }

    func testComparable_LessThan2() {
        let bv1 = BiftVector(uintVal: 127, size: 7)
        let bv2 = BiftVector(uintVal: 127, size: 7)
        XCTAssertFalse(bv1 < bv2)
    }

    func testComparable_LessThanOrEqual() {
        let bv1 = BiftVector(uintVal: 127, size: 7)
        let bv2 = BiftVector(uintVal: 128, size: 7)
        XCTAssertFalse(bv1 <= bv2, "Error on comparison of \(bv1) <= \(bv2)")
    }

    func testComparable_LessThanOrEqual2() {
        let bv1 = BiftVector(uintVal: 127, size: 8)
        let bv2 = BiftVector(uintVal: 128, size: 8)
        XCTAssertTrue(bv1 <= bv2, "Error on comparison of \(bv1) <= \(bv2)")
    }

    func testComparable_GreatThan() {
        let bv1 = BiftVector(uintVal: 255, size: 8)
        let bv2 = BiftVector(uintVal: 127, size: 8)
        XCTAssertTrue(bv1 > bv2)
    }

    func testComparable_GreaterThanOrEqual() {
        let bv1 = BiftVector(uintVal: 127, size: 8)
        let bv2 = BiftVector(uintVal: 127, size: 8)
        XCTAssertTrue(bv1 >= bv2)
    }

    func testSlice_SingleBiftBitRead() {
        let bv = BiftVector(hexString: "aecafBADc0ffee600DdecafBADc0ffee600D")
        let size = bv.size

        // MSBs (0xa)
        let bitMSB0 = bv[size-1]
        let bitMSB1 = bv[size-2]
        let bitMSB2 = bv[size-3]
        let bitMSB3 = bv[size-4]
        XCTAssertTrue( (true, false, true, false) == (bitMSB0, bitMSB1, bitMSB2, bitMSB3),
                       "(bitMSB0, bitMSB0, bitMSB0, bitMSB0) are (\(bitMSB0), \(bitMSB1), \(bitMSB2), \(bitMSB3))")
        // LSBs (0xd)
        let bit0 = bv[0]
        let bit1 = bv[1]
        let bit2 = bv[2]
        let bit3 = bv[3]
        XCTAssertTrue( (true, true, false, true) == (bit3, bit2, bit1, bit0),
                       "(bit3, bit2, bit1, bit0) are (\(bit3), \(bit2), \(bit1), \(bit0))")
    }

    func testSlice_SingleBiftBitRead2() {
        let bv = BiftVector(hexString: "7a")
        let bit0 = bv[0]
        let bit1 = bv[1]
        let bit2 = bv[2]
        let bit3 = bv[3]
        XCTAssertTrue( (true, false, true, false) == (bit3, bit2, bit1, bit0),
                       "(bit3, bit2, bit1, bit0) are (\(bit3), \(bit2), \(bit1), \(bit0))")
    }
    
    // FIXME: Add throws for subscript out of range?
//    func testSlice_SingleBiftBitReadOutOfRange() {
//        let bv = BiftVector(uintVal: 127, size: 7)
//        let index = 7
//        var bit : Bool?
//        XCTAssertThrowsError(try bit = bv[index])
//    }

}



#if os(Linux)
extension BiftVectorTests {
    static var allTests : [(String, (BiftVectorTests) -> () throws -> Void)] {
        // FIXME: Should have a complete list of test cases (for Linux)
        return [
            ("testInit_AcceptsSizeZero", testInit_AcceptsSizeZero),
        ]
    }
}
#endif
