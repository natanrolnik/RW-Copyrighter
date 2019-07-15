import XCTest

#if !canImport(ObjectiveC)
public func allTests() -> [XCTestCaseEntry] {
    return [
        testCase(RW_CopyrighterTests.allTests),
    ]
}
#endif
