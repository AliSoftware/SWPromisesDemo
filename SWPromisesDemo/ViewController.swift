//
//  ViewController.swift
//  SWPromisesDemo
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
        
        // - Given a ship, send all the requests (in parallel) to fetch all its pilots
        //   by using map() to transform the Array<ResourceURL<Starship>> into an Array<Promise<Starship>>
        // - Wait for all pilot requests to finish (using when() to wait until all promises are fulfilled)
        //   then print the starship and all its pilots.
        func printShipWithPilots(ship: Starship) {
            when(ship.pilots.map { $0.fetch() }).then { (pilots :[Person]) -> Void in
                println("-- Starship: \(ship.name), \(ship.model)")
                for pilot in pilots { println("   '-- Pilot: \(pilot)") }
            }
        }

        // Fetch person with ID 1, then print it and iterate thru all its ships
        ResourceURL<Person>.fetch(id: 1)
            .then({ (p: Person) -> Void in
                println("First person found: \(p)")
                for ship in p.starships {
                    // fetch each ship resource then print it
                    ship.fetch().then(printShipWithPilots)
                }
            })
    }

}

