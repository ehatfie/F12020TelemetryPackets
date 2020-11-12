import XCTest
@testable import F12020TelemetryPackets
@testable import NIO

final class F12020TelemetryPacketsTests: XCTestCase {
    func testExample() {
        // This is an example of a functional test case.
        // Use XCTAssert and related functions to verify your tests produce the correct
        // results.
        XCTAssertEqual(F12020TelemetryPackets().text, "Hello, World!")
    }
    
    func testReadInt() {
        let testValue: UInt8 = 1
        let invalidValue = 2
        var buffer = ByteBuffer(integer: testValue, as: UInt8.self)
        let readValue = buffer.readInt(as: UInt8.self)
        XCTAssertNotNil(readValue)
        XCTAssertEqual(Int(testValue), readValue)
        XCTAssertNotEqual(invalidValue, readValue)
    }
    
    func testReadMultipleInt() {
        let testValue: UInt8 = 1
        let count = 4
        let validValues = makeArray(count: count, from: testValue)
        let invalidValues = makeArray(count: count, from: 2)
        var buffer = ByteBuffer(repeating: testValue, count: count)
        let readValues = buffer.readMultipleInt(count: count, as: UInt8.self)
        
        XCTAssertNotNil(readValues)
        XCTAssertEqual(readValues, validValues)
        XCTAssertNotEqual(readValues, invalidValues)
    }

    static var allTests = [
        ("testExample", testExample),
    ]
    
    func makeArray<T: FixedWidthInteger>(count: Int, from value: T) -> [Int] {
        var returnValue:[Int] = []
        for _ in 0 ..< count {
            returnValue.append(Int(value))
        }
        return returnValue
    }
}
