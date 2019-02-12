//
//  PageOfPeople.swift
//  StarWarsPeople
//
//  Created by Josh Elkins on 2/12/19.
//  Copyright © 2019 Josh Elkins. All rights reserved.
//

import Foundation


struct PageOfPeople: Codable, Equatable {
    let totalCount: Int
    let previousPageURL: String?
    let nextPageURL: String?
    let people: [Person]

    enum CodingKeys: String, CodingKey {
        case totalCount = "count"
        case previousPageURL = "previous"
        case nextPageURL = "next"
        case people = "results"
    }
}
