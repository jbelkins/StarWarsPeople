//
//  MasterViewController.swift
//  StarWarsPeople
//
//  Created by Josh Elkins on 2/11/19.
//  Copyright © 2019 Josh Elkins. All rights reserved.
//

import UIKit


class MasterViewController: UITableViewController {
    var detailViewController: DetailViewController? = nil
    var dataSource: MasterDataSource!

    // MARK: - UIViewController overrides

    override func viewDidLoad() {
        super.viewDidLoad()
        if let split = splitViewController {
            let controllers = split.viewControllers
            detailViewController = (controllers[controllers.count-1] as! UINavigationController).topViewController as? DetailViewController
        }
        let swapi = SWAPIAdapter(urlSession: URLSession.shared)
        let peopleClient = PeopleClient(swapi: swapi)
        dataSource = MasterDataSource(peopleClient: peopleClient)
        tableView.dataSource = dataSource
        loadPeople()
    }

    override func viewWillAppear(_ animated: Bool) {
        clearsSelectionOnViewWillAppear = splitViewController!.isCollapsed
        super.viewWillAppear(animated)
    }

    // MARK: - Data retrieval

    func loadPeople() {
        dataSource.reloadPeople() { [weak self] people, error in
            guard let self = self else { return }
            if let error = error {
                self.presentError(error)
            } else {
                self.tableView.reloadData()
            }
        }
    }

    // MARK: - Error presentation

    func presentError(_ error: Error) {
        let alert = UIAlertController(title: "Error", message: error.localizedDescription, preferredStyle: .alert)
        let okAction = UIAlertAction(title: "OK", style: .default, handler: nil)
        alert.addAction(okAction)
        self.present(alert, animated: true, completion: nil)
    }

    // MARK: - Segue handling

    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        guard segue.identifier == "showDetail", let indexPath = tableView.indexPathForSelectedRow else { return }
        let person = dataSource.people[indexPath.row]
        let controller = (segue.destination as! UINavigationController).topViewController as! DetailViewController
        controller.person = person
    }
}
