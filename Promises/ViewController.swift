//
//  ViewController.swift
//  Promises
//
//  Created by Olivier Halligon on 22/02/2015.
//  Copyright (c) 2015 AliSoftware. All rights reserved.
//

import UIKit
import PromiseKit

class ViewController: UIViewController {

    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view, typically from a nib.

        println("Fetching person #1…")
        Fetcher<Person>.fetch(id: 1).then { p in
            println("Person found: \(p), starships: \(p.starships)")
        }
    }

}

