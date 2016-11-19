import XCTest
@testable import BiftVector

class BiftVectorTests: XCTestCase {
    
    override func setUp() {
        super.setUp()
        //viewController = ViewController()
    }
    
    func testInit_Example() {
        // This is an example of a functional test case.
        // Use XCTAssert and related functions to verify your tests produce the correct results.
        XCTAssertEqual(BiftVector(size: 0)!.description, "FIXME")
    }
    
    func testInit_AcceptsSizeZero() {
        let bv = BiftVector(size: 0)
        XCTAssertEqual(bv!.description, "FIXME")
    }

    func testInit_AcceptsSizeLessThan64() {
        let bv = BiftVector(size: 33)
        XCTAssertEqual(bv!.description, "FIXME")
    }
    
    func testInit_AcceptsSizeGreaterThan64() {
        let bv = BiftVector(size: 65)
        XCTAssertEqual(bv!.description, "FIXME")
    }
    

    static var allTests : [(String, (BiftVectorTests) -> () throws -> Void)] {
        return [
            ("testInit_Example", testInit_Example),
            ("testInit_AcceptsSizeZero", testInit_AcceptsSizeZero),
        ]
    }
}
