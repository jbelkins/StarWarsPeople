//
//  PeopleClientInterface.swift
//  StarWarsPeople
//
//  Created by Josh Elkins on 2/12/19.
//  Copyright © 2019 Josh Elkins. All rights reserved.
//

import Foundation


protocol PeopleClientInterface {
    func getPeople(pageURL: String?, completion: @escaping (APIResponse<PageOfPeople>) -> Void) -> URLSessionDataTask
}
