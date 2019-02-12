//
//  PeopleClient.swift
//  StarWarsPeople
//
//  Created by Josh Elkins on 2/12/19.
//  Copyright © 2019 Josh Elkins. All rights reserved.
//

import Foundation


struct PeopleClient: PeopleClientInterface {
    let swapi: SWAPIAdapterInterface

    func getPeople(pageURL: String?, completion: @escaping (APIResponse<PageOfPeople>) -> Void) -> URLSessionDataTask {
        let url = URL(string: pageURL ?? "https://swapi.co/api/people")!
        return swapi.get(url: url, completion: completion)
    }
}
