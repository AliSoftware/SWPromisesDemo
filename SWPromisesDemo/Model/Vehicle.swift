//
//  Vehicle.swift
//  SWPromisesDemo
//
//  Created by Olivier Halligon on 22/02/2015.
//  Copyright (c) 2015 AliSoftware. All rights reserved.
//

import Foundation

struct Vehicle : JSONModelObject {
    static var apiEndPoint: String { return "vehicles" }
    let resourceInfo: ResourceInfo
    
    let name: String
    let model: String
    let vehicle_class: String
    let manufacturer: [String]?
    let length: Int?            // in meters
    let cost_in_credits: Int?   // in Galactic Credits.
    let crew: Int?
    let passengers: Int?
    let max_atmosphering_speed: Int?
    let cargo_capacity: Int?    // in kilograms that this vehicle can transport.
    let consumables: String
    let films: [ResourceURL<Film>]
    let pilots: [ResourceURL<Person>]
    
    init(dict: NSDictionary) {
        name = dict["name"] as String
        model = dict["model"] as String
        vehicle_class = dict["vehicle_class"] as String
        manufacturer = parseStringList(dict["manufacturer"] as String)
        length = (dict["length"] as String).toInt()
        cost_in_credits = (dict["cost_in_credits"] as String).toInt()
        crew = (dict["crew"] as String).toInt()
        passengers = (dict["passengers"] as String).toInt()
        max_atmosphering_speed = (dict["max_atmosphering_speed"] as String).toInt()
        cargo_capacity = (dict["cargo_capacity"] as String).toInt()
        consumables = dict["consumables"] as String
        films = (dict["films"] as [String]).map { ResourceURL<Film>(url: $0) }
        pilots = (dict["pilots"] as [String]).map { ResourceURL<Person>(url: $0) }
        
        resourceInfo = ResourceInfo(dict: dict)
    }
}

extension Vehicle : Printable {
    var description: String {
        return "<Vehicle #\(resourceInfo.id!): \(name) (\(model))>"
    }
}
