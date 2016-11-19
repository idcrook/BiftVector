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
    
    static var allTests : [(String, (BiftVectorTests) -> () throws -> Void)] {
        // FIXME: Should have a complete list of test cases (for Linux)
        return [
            ("testInit_AcceptsSizeZero", testInit_AcceptsSizeZero),
        ]
    }
}
