//
//  SWAPIAdapterInterface.swift
//  StarWarsPeople
//
//  Created by Josh Elkins on 2/12/19.
//  Copyright © 2019 Josh Elkins. All rights reserved.
//

import Foundation


enum APIResponse<T: Codable> {
    case success(T)
    case failure(Error)
}


protocol SWAPIAdapterInterface {
    func get<T: Decodable>(url: URL, completion: @escaping (APIResponse<T>) -> Void) -> URLSessionDataTask
}
