//
//  MasterDataSourceTests.swift
//  StarWarsPeopleTests
//
//  Created by Josh Elkins on 2/12/19.
//  Copyright © 2019 Josh Elkins. All rights reserved.
//

import XCTest
@testable import StarWarsPeople


class MasterDataSourceTests: XCTestCase {
    var peopleClientMock: PeopleClientMock!
    var subject: MasterDataSource!

    override func setUp() {
        peopleClientMock = PeopleClientMock()
        subject = MasterDataSource(peopleClient: peopleClientMock)
    }

    override func tearDown() {
        peopleClientMock = nil
        subject = nil
    }

    // MARK: - Reload people

    func testReloadPeople_CallsBackWithPeopleAndNoErrorFromTheAPI() {
        var returnedPeople: [Person]?
        var returnedError: Error?

        // Call the function to be tested with a completion block that records the passed values
        subject.reloadPeople { (people, error) in
            returnedPeople = people
            returnedError = error
        }

        // Make the mock run the completion block now (synchronous) rather than later (async)
        peopleClientMock.finishSuccessfully(pageOfPeople: Fixtures.testPage)

        // Now test that the people were returned and there is no error
        XCTAssertTrue(returnedPeople == Fixtures.testPage.people, "Returned people should have been the same as on the test page")
        XCTAssertNil(returnedError, "Error should have been nil")
    }

    func testReloadPeople_CallsBackWithErrorAndNoPeopleFromTheAPI() {
        var returnedPeople: [Person]?
        var returnedError: Error?

        // Call the function to be tested with a completion block that records the passed values
        subject.reloadPeople { (people, error) in
            returnedPeople = people
            returnedError = error
        }

        // Make the mock run the completion block now (synchronous) rather than later (async)
        peopleClientMock.finishWithFailure(error: Fixtures.peopleError)

        // Now test that the an error was returned and no people were returned
        XCTAssertNil(returnedPeople, "Returned people should have been nil")
        XCTAssertEqual(returnedError?.localizedDescription, Fixtures.peopleError.localizedDescription, "Error from test fixtures should have been returned")
    }
}
