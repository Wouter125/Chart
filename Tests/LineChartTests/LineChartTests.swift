import XCTest
@testable import LineChart

final class LineChartTests: XCTestCase {
    func testExample() {
        // This is an example of a functional test case.
        // Use XCTAssert and related functions to verify your tests produce the correct
        // results.
        XCTAssertEqual(LineChart().text, "Hello, World!")
    }

    static var allTests = [
        ("testExample", testExample),
    ]
}
