import XCTest

#if !canImport(ObjectiveC)
public func allTests() -> [XCTestCaseEntry] {
    return [
        testCase(F12020TelemetryPacketsTests.allTests),
    ]
}
#endif
