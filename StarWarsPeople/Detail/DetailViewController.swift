//
//  DetailViewController.swift
//  StarWarsPeople
//
//  Created by Josh Elkins on 2/11/19.
//  Copyright © 2019 Josh Elkins. All rights reserved.
//

import UIKit

class DetailViewController: UIViewController {

    @IBOutlet weak var detailDescriptionLabel: UILabel!


    func configureView() {
        // Update the user interface for the detail item.
        if let person = person {
            if let label = detailDescriptionLabel {
                label.text = person.name
            }
        }
    }

    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view, typically from a nib.
        configureView()
    }

    var person: Person! {
        didSet {
            // Update the view.
            configureView()
        }
    }


}

