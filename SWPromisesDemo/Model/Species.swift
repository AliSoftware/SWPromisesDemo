//
//  Species.swift
//  SWPromisesDemo
//
//  Created by Olivier Halligon on 22/02/2015.
//  Copyright (c) 2015 AliSoftware. All rights reserved.
//

import Foundation

struct Species : JSONModelObject {
    static var apiEndPoint: String { return "species" }
    let resourceInfo: ResourceInfo
    
    let name: String
    let classification: String
    let designation: String
    let average_height: Int?    // in centimeters.
    let average_lifespan: Int?  // in years.
    let eye_colors: [String]?
    let hair_colors: [String]?
    let skin_colors: [String]?
    let language: String
    let homeworld: ResourceURL<Planet>
    let people: [ResourceURL<Person>]
    let films: [ResourceURL<Film>]
    
    init(dict: NSDictionary) {
        name = dict["name"] as! String
        classification = dict["classification"] as! String
        designation = dict["designation"] as! String
        average_height = (dict["average_height"] as! String).toInt()
        average_lifespan = (dict["average_lifespan"] as! String).toInt()
        
        eye_colors = parseStringList(dict["eye_colors"] as! String)
        hair_colors = parseStringList(dict["hair_colors"] as! String)
        skin_colors = parseStringList(dict["skin_colors"] as! String)
        
        language = dict["language"] as! String
        homeworld = ResourceURL<Planet>(url:(dict["homeworld"] as! String))
        people = (dict["people"] as! [String]).map { ResourceURL<Person>(url: $0) }
        films = (dict["films"] as! [String]).map { ResourceURL<Film>(url: $0) }
        
        resourceInfo = ResourceInfo(dict: dict)
    }
}

extension Species : Printable {
    var description: String {
        return "<Species #\(resourceInfo.id!): \(name)>"
    }
}
