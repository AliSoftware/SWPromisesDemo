//
//  Planet.swift
//  SWPromisesDemo
//
//  Created by Olivier Halligon on 22/02/2015.
//  Copyright (c) 2015 AliSoftware. All rights reserved.
//

import Foundation

struct Planet : JSONModelObject {
    static var apiEndPoint: String { return "planets" }
    let resourceInfo: ResourceInfo
    
    let name: String
    let diameter: Int?        // In kilometers
    let rotation_period: Int? // The number of standard hours it takes for this planet to complete a single rotation on it's axis.
    let orbital_period: Int?  // The number of standard days it takes for this planet to complete a single orbit of it's local star.
    let gravity: Double
    let population: Int?
    let climate: String
    let terrain: String
    let surface_water: Double // The percentage of the planet surface that is naturally occuring water or bodies of water.
    let residents: [ResourceURL<Person>]
    let films: [ResourceURL<Film>]
    
    init(dict: NSDictionary) {
        name = dict["name"] as String
        diameter = (dict["diameter"] as String).toInt()
        rotation_period = (dict["rotation_period"] as String).toInt()
        orbital_period = (dict["orbital_period"] as String).toInt()
        gravity = (dict["gravity"] as NSString).doubleValue
        population = (dict["population"] as String).toInt()
        climate = dict["climate"] as String
        terrain = dict["terrain"] as String
        surface_water = (dict["surface_water"] as NSString).doubleValue / 100 // The value express a percentage
        residents = (dict["residents"] as [String]).map { ResourceURL<Person>(url: $0) }
        films = (dict["films"] as [String]).map { ResourceURL<Film>(url: $0) }
        
        resourceInfo = ResourceInfo(dict: dict)
    }
}

extension Planet : Printable {
    var description: String {
        let popStr = (population != nil) ? "\(population)" : "N/A"
        return "<Planet #\(resourceInfo.id!): \(name) (\(popStr) inhab.)>"
    }
}
