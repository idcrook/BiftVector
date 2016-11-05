import XCTest
@testable import BiftVector

class BiftVectorTests: XCTestCase {
    func testExample() {
        // This is an example of a functional test case.
        // Use XCTAssert and related functions to verify your tests produce the correct results.
        XCTAssertEqual(BiftVector().text, "Hello, World!")
    }


    static var allTests : [(String, (BiftVectorTests) -> () throws -> Void)] {
        return [
            ("testExample", testExample),
        ]
    }
}
