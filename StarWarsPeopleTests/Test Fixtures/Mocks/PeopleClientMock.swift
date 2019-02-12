//
//  PeopleClientMock.swift
//  StarWarsPeopleTests
//
//  Created by Josh Elkins on 2/12/19.
//  Copyright © 2019 Josh Elkins. All rights reserved.
//

import Foundation
@testable import StarWarsPeople


class PeopleClientMock: PeopleClientInterface {
    var pageURL: String?
    var completion: ((APIResponse<PageOfPeople>) -> Void)?

    func getPeople(pageURL: String?, completion: @escaping (APIResponse<PageOfPeople>) -> Void) -> URLSessionDataTask {
        self.pageURL = pageURL
        self.completion = completion
        return URLSessionDataTask()
    }

    func finishSuccessfully(pageOfPeople: PageOfPeople) {
        completion?(APIResponse<PageOfPeople>.success(pageOfPeople))
    }

    func finishWithFailure(error: Error) {
        completion?(APIResponse<PageOfPeople>.failure(error))
    }
}
