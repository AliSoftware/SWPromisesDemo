//
//  Starship.swift
//  SWPromisesDemo
//
//  Created by Olivier Halligon on 22/02/2015.
//  Copyright (c) 2015 AliSoftware. All rights reserved.
//

import Foundation

struct Starship : JSONModelObject {
    static var apiEndPoint: String { return "starships" }
    let resourceInfo: ResourceInfo

    let characteristics: VehicleData
    let starship_class: String
    let hyperdrive_rating: Double
    let megalight_speed: Double // The Maximum number of "Megalights" this starship can travel in a standard hour.
    let films: [ResourceURL<Film>]
    let pilots: [ResourceURL<Person>]
    
    init(dict: NSDictionary) {
        characteristics = VehicleData(dict: dict)
        starship_class = dict["starship_class"] as! String
        hyperdrive_rating = (dict["hyperdrive_rating"] as! NSString).doubleValue
        megalight_speed = (dict["MGLT"] as! NSString).doubleValue
        films = (dict["films"] as! [String]).map { ResourceURL<Film>(url: $0) }
        pilots = (dict["pilots"] as! [String]).map { ResourceURL<Person>(url: $0) }
        
        resourceInfo = ResourceInfo(dict: dict)
    }
}

extension Starship : Printable {
    var description: String {
        return "<Starship #\(resourceInfo.id!): \(characteristics.name) (\(characteristics.model))>"
    }
}
