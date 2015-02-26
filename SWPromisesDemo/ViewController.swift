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

//        fetchFirstPersonAndPrintVehicles()
        fetchFalconAndPrintPilotsHomeworld()

    }

    private func fetchFalconAndPrintPilotsHomeworld() {
        let falcon = ResourceURL<Starship>(id: 10)
        falcon.fetch().then({ (ship: Starship) -> Promise<Person> in
            let nbPilots = countElements(ship.pilots)
            println("--> Starship found: \(ship) (\(nbPilots) pilots)")
            let aPilot = ship.pilots[0] // a ResourceURL<Pilot>
            return aPilot.fetch()
        }).then({ (pilot: Person) -> Void in
            println("--> Pilot found: \(pilot)")
            
            // Fetch all films the pilot played into
            when(pilot.films.map{$0.fetch()}).then({ films in
                println("    --> Played in: \(films)")
            })
            
            // Fetch all vehicles the pilot drove
            when(pilot.vehicles.map{$0.fetch()}).then({ vehicles in
                println("    --> Drove: \(vehicles)")
            })
            
            
            let homeplanet = pilot.homeworld // a ResourceURL<Planet>
            homeplanet.fetch().then({ planet in
                println("    --> Homeworld: \(planet)")
            })
            
            let species = pilot.species // an array of ResourceURL<Species>
            species[0].fetch().then({ species in
                println("    --> Main Species: \(species)")
            })
        })
    }
    
    private func fetchFirstPersonAndPrintVehicles() {
        println("Fetching person #1…")
        
        // - Given a vehicle, send all the requests (in parallel) to fetch all its pilots
        //   by using map() to transform the [<ResourceURL<Vehicle>] array into an [Promise<Vehicle>] array
        // - Wait for all pilot requests to finish (using when() to wait until all promises are fulfilled)
        //   then print the vehicle and all its pilots.
        func printVehicleWithPilots(vehicle: Vehicle) {
            when(vehicle.pilots.map { $0.fetch() }).then { (pilots :[Person]) -> Void in
                println("-- Vehicle: \(vehicle.name), \(vehicle.model)")
                for pilot in pilots { println("   '-- Pilot: \(pilot)") }
            }
        }
        
        // Fetch person with ID 1, then print it and iterate thru all its ships
        ResourceURL<Person>.fetch(id: 1)
            .then({ (p: Person) -> Void in
                println("First person found: \(p)")
                for vehicle in p.vehicles {
                    // fetch each ship resource then print it
                    vehicle.fetch().then(printVehicleWithPilots)
                }
            })
    }
    
}

