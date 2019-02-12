//
//  Person.swift
//  StarWarsPeople
//
//  Created by Josh Elkins on 2/12/19.
//  Copyright © 2019 Josh Elkins. All rights reserved.
//

import Foundation


struct Person: Codable, Equatable {
    let name: String
    let birthYear: String?
    let eyeColor: String?
    let hairColor: String?
    let height: String?

    enum CodingKeys: String, CodingKey {
        case name
        case birthYear = "birth_year"
        case eyeColor = "eye_color"
        case hairColor = "hair_color"
        case height
    }
}
