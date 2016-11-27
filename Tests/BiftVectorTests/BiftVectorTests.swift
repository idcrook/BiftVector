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

    func testDebugExtension_descriptionSizeOf63() {
        let bv = BiftVector(size: 63)
        XCTAssertEqual(bv.description, "000000000000000000000000000000000000000000000000000000000000000")
    }
    
    func testDebugExtension_descriptionSizeOf64() {
        let bv = BiftVector(size: 64)
        XCTAssertEqual(bv.description, "0000000000000000000000000000000000000000000000000000000000000000")
    }
    
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
