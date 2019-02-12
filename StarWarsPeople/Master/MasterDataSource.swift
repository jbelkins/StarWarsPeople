//
//  MasterDataSource.swift
//  StarWarsPeople
//
//  Created by Josh Elkins on 2/12/19.
//  Copyright © 2019 Josh Elkins. All rights reserved.
//

import UIKit


class MasterDataSource: NSObject, UITableViewDataSource {
    let peopleClient: PeopleClientInterface
    var people = [Person]()

    // MARK: - Initializers

    init(peopleClient: PeopleClientInterface) {
        self.peopleClient = peopleClient
    }

    func reloadPeople(completion: @escaping ([Person]?, Error?) -> Void) {
        let _ = peopleClient.getPeople(pageURL: nil) { [weak self] (response: APIResponse<PageOfPeople>) in
            guard let self = self else { return }
            switch response {
            case .success(let pageOfPeople):
                self.people = pageOfPeople.people
                completion(pageOfPeople.people, nil)
            case .failure(let error):
                completion(nil, error)
            }
        }
    }

    // MARK: - UITableViewDataSource protocol

    func numberOfSections(in tableView: UITableView) -> Int {
        return 1
    }

    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return people.count
    }

    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "Cell", for: indexPath)
        let person = people[indexPath.row]
        cell.textLabel!.text = person.name
        return cell
    }
}
