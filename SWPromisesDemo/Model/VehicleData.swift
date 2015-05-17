//
//  VehicleData.swift
//  SWPromisesDemo
//
//  Created by Olivier Halligon on 26/02/2015.
//  Copyright (c) 2015 AliSoftware. All rights reserved.
//

import Foundation

struct VehicleData {
    let name: String
    let model: String
    let manufacturer: [String]?
    let length: Int?            // in meters
    let cost: Int?   // in Galactic Credits.
    let crew: Int?
    let passengers: Int?
    let max_atmosphering_speed: Int?
    let cargo_capacity: Int?    // in kilograms that this vehicle can transport.
    let consumables: String
    
    init(dict: NSDictionary) {
        name = dict["name"] as! String
        model = dict["model"] as! String
        manufacturer = parseStringList(dict["manufacturer"] as! String)
        length = (dict["length"] as! String).toInt()
        cost = (dict["cost_in_credits"] as! String).toInt()
        crew = (dict["crew"] as! String).toInt()
        passengers = (dict["passengers"] as! String).toInt()
        max_atmosphering_speed = (dict["max_atmosphering_speed"] as! String).toInt()
        cargo_capacity = (dict["cargo_capacity"] as! String).toInt()
        consumables = dict["consumables"] as! String
    }
}
