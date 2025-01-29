//
//  SessionManagerTests.swift
//  TableViewDemoExcersiseTests
//
//  Created by Basil Hijaz on 28/01/2025.
//

import XCTest
@testable import TableViewDemoExcersise

// TODO: Add some tests for SessionManager
final class SessionManagerTests: XCTestCase {

    private var sessionManager: SessionManager!
    private var userDefaults: UserDefaults!

    override func setUpWithError() throws {
        try super.setUpWithError()
        userDefaults = .init(suiteName: className)
        sessionManager = .init(userDefaults: userDefaults)
    }

    override func tearDownWithError() throws {
        try super.tearDownWithError()
        sessionManager = nil
        userDefaults.removePersistentDomain(forName: className)
        userDefaults = nil
    }

    func testExample() throws {
        // This is an example of a functional test case.
        // Use XCTAssert and related functions to verify your tests produce the correct results.
        // Any test you write for XCTest can be annotated as throws and async.
        // Mark your test throws to produce an unexpected failure when your test encounters an uncaught error.
        // Mark your test async to allow awaiting for asynchronous code to complete. Check the results with assertions afterwards.
    }

    func testPerformanceExample() throws {
        // This is an example of a performance test case.
        self.measure {
            // Put the code you want to measure the time of here.
        }
    }

}
