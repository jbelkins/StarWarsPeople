//
//  TestPeople.swift
//  StarWarsPeopleTests
//
//  Created by Josh Elkins on 2/12/19.
//  Copyright © 2019 Josh Elkins. All rights reserved.
//

import Foundation
@testable import StarWarsPeople


enum Fixtures {
    static let darkHelmet = Person(name: "Dark Helmet", birthYear: "1984", eyeColor: "Black", hairColor: "Brown", height: "100")
    static let barf = Person(name: "Barf", birthYear: "1984", eyeColor: "Brown", hairColor: "Brown", height: "200")

    static let testPage = PageOfPeople(totalCount: 2, previousPageURL: nil, nextPageURL: "https://swapi.co/api/people/?page=2", people: [Fixtures.darkHelmet, Fixtures.barf])
    static let peopleError: Error = "Error that happened while getting people"
}
