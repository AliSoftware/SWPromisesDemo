//
//  Starship.swift
//  SWPromisesDemo
//
//  Created by Olivier Halligon on 22/02/2015.
//  Copyright (c) 2015 AliSoftware. All rights reserved.
//

import Foundation

struct Starship : JSONModelObject, Printable {
    static var apiEndPoint: String { return "starships" }
    let resourceInfo: ResourceInfo
    
    let name: String
    let model: String
    let starship_class: String
    let manufacturer: String
    let cost: Double // in credits
    let length: Double // in meters.
    let crew: Int?
    let passengers: Int?
    let max_atmosphering_speed: Double?
    let hyperdrive_rating: Double
    let MGLT: Double
    let cargo_capacity: Int? // in kilograms that this starship can transport.
    let consumables: String
    let films: [ResourceURL<Film>]
    let pilots: [ResourceURL<Person>]
    
    init(dict: NSDictionary) {
        name = dict["name"] as String
        model = dict["model"] as String
        starship_class = dict["starship_class"] as String
        manufacturer = dict["manufacturer"] as String
        cost = (dict["cost_in_credits"] as NSString).doubleValue
        length = (dict["length"] as NSString).doubleValue
        crew = (dict["crew"] as String).toInt()
        passengers = (dict["passengers"] as String).toInt()
        max_atmosphering_speed = (dict["max_atmosphering_speed"] as NSString).doubleValue
        hyperdrive_rating = (dict["hyperdrive_rating"] as NSString).doubleValue
        MGLT = (dict["MGLT"] as NSString).doubleValue
        cargo_capacity = (dict["cargo_capacity"] as String).toInt()
        consumables = dict["consumables"] as String
        films = (dict["films"] as [String]).map { ResourceURL<Film>(url: $0) }
        pilots = (dict["pilots"] as [String]).map { ResourceURL<Person>(url: $0) }
        
        resourceInfo = ResourceInfo(dict: dict)
    }

    var description: String { return "\(name) (\(model))>" }
}
