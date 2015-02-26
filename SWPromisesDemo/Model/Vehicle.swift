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
    
    let characteristics: VehicleData
    let vehicle_class: String
    let films: [ResourceURL<Film>]
    let pilots: [ResourceURL<Person>]
    
    init(dict: NSDictionary) {
        characteristics = VehicleData(dict: dict)
        vehicle_class = dict["vehicle_class"] as String
        films = (dict["films"] as [String]).map { ResourceURL<Film>(url: $0) }
        pilots = (dict["pilots"] as [String]).map { ResourceURL<Person>(url: $0) }
        
        resourceInfo = ResourceInfo(dict: dict)
    }
}

extension Vehicle : Printable {
    var description: String {
        return "<Vehicle #\(resourceInfo.id!): \(characteristics.name) (\(characteristics.model))>"
    }
}
