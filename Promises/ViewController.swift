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
        
        func printShipWithPilots(ship: Starship) {
//            println("  >>> Fetching pilots of \(ship.name)")
            when(ship.pilots.map { $0.fetch() }).then { (pilots :[Person]) -> Void in
                println("-- Starship: \(ship.name), \(ship.model)")
                for pilot in pilots { println("   '-- Pilot: \(pilot)") }
            }
        }

        ResourceFetcher<Person>.fetch(id: 1)
            .then({ (p: Person) -> Void in
                println("First person found: \(p)")
                for ship in p.starships {
                    ship.fetch().then(printShipWithPilots)
                }
            })
    }

}

