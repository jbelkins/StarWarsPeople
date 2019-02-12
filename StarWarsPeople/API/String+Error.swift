//
//  String+Error.swift
//  StarWarsPeople
//
//  Created by Josh Elkins on 2/12/19.
//  Copyright © 2019 Josh Elkins. All rights reserved.
//

import Foundation


extension String: Error {
    var localizedDescription: String {
        return self
    }
}
