//
//  SWAPIAdapterTests.swift
//  StarWarsPeopleTests
//
//  Created by Josh Elkins on 2/12/19.
//  Copyright © 2019 Josh Elkins. All rights reserved.
//

import XCTest
import OHHTTPStubs
@testable import StarWarsPeople


class SWAPIAdapterTests: XCTestCase {
    var subject: SWAPIAdapter!

    override func setUp() {
        subject = SWAPIAdapter(urlSession: URLSession.shared)
        stub(condition: isHost("swapi.co")) { _ in
            // Stub it with our "wsresponse.json" stub file (which is in same bundle as self)
            let stubPath = OHPathForFile("PageOfPeople.json", type(of: self))
            return fixture(filePath: stubPath!, headers: ["Content-Type": "application/json"])
        }
    }

    override func tearDown() {
        subject = nil
        OHHTTPStubs.removeAllStubs()
    }

    func testGet_WithoutWaiting_ParsesAnObjectOnSuccess() {
        let url = URL(string: "https://swapi.co/api/people/")!

        // Variables to store the result of the operation
        var returnedPage: PageOfPeople?
        var returnedError: Error?

        let _ = subject.get(url: url) { (response: APIResponse<PageOfPeople>) in
            switch response {
            case .success(let pageOfPeople):
                returnedPage = pageOfPeople
            case .failure(let error):
                returnedError = error
            }
        }

        // After get() is called on the subject, it returns immediately.  XCTest moves onto the assertions before the stubbed response can be returned and the completion block is called.
        XCTAssertEqual(returnedPage, Fixtures.testPage, "The returned page should have been the same as the test page")
        XCTAssertNil(returnedError, "No error should have been returned")
    }

    func testGet_WithWaiting_ParsesAnObjectOnSuccess() {
        let url = URL(string: "https://swapi.co/api/people/")!

        // Variables to store the result of the operation
        var returnedPage: PageOfPeople?
        var returnedError: Error?

        // Create an expectation that will fulfill when the completion block is done.
        let requestComplete = expectation(description: "API request complete")

        // Make the API request with a completion block that records the returned values and fulfills the expectation.
        let _ = subject.get(url: url) { (response: APIResponse<PageOfPeople>) in
            switch response {
            case .success(let pageOfPeople):
                returnedPage = pageOfPeople
            case .failure(let error):
                returnedError = error
            }
            // Since all required actions have been taken, the expectation is now fulfilled so the test may move on to assertions without further delay.
            requestComplete.fulfill()
        }

        // waitForExpectations() will spin the run loop until either the timeout is reached, or fulfill() is called on all expectations.
        waitForExpectations(timeout: 1.0, handler: nil)

        // If the API request completed before the timeout, then returnedPage and returnedError have been set by the completion block.  If the test timed out, then XCTest moves on to assertions anyway to prevent hanging the test suite.
        XCTAssertEqual(returnedPage, Fixtures.testPage, "The returned page should have been the same as the test page")
        XCTAssertNil(returnedError, "No error should have been returned")
    }
}
