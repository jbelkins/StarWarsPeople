//
//  SWAPIAdapter.swift
//  StarWarsPeople
//
//  Created by Josh Elkins on 2/11/19.
//  Copyright © 2019 Josh Elkins. All rights reserved.
//

import Foundation


struct SWAPIAdapter: SWAPIAdapterInterface {
    let urlSession: URLSession

    func get<T: Decodable>(url: URL, completion: @escaping (APIResponse<T>) -> Void) -> URLSessionDataTask {
        let task = urlSession.dataTask(with: url, completionHandler: { (data, urlResponse, error) in
            var apiResponse: APIResponse<T>
            if let error = error {
                apiResponse = .failure(error)
            } else if let data = data {
                do {
                    let decodedResponse = try JSONDecoder().decode(T.self, from: data)
                    apiResponse = .success(decodedResponse)
                } catch let error {
                    apiResponse = .failure(error)
                }
            } else {
                apiResponse = .failure("An unknown error occurred.")
            }
            DispatchQueue.main.async {
                completion(apiResponse)
            }
        })
        task.resume()
        return task
    }
}
