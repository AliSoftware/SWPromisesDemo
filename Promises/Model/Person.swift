//
//  People.swift
//  Promises
//
//  Created by Olivier Halligon on 22/02/2015.
//  Copyright (c) 2015 AliSoftware. All rights reserved.
//

import Foundation
import PromiseKit

enum Gender : String {
    case Male = "Male"
    case Female = "Female"
    case Unknown = "unknown"
}


struct Person : JSONModelObject, Printable {
    static var apiEndPoint: String { return "people" }
    
    let name: String
    let birth_year: Int?  // Relative to the Battle of Yavin (Star Wars episode IV: A New Hope)
    let eye_color: String
    let gender: Gender?
    let hair_color: String
    let height: Int?      // in centimeters.
    let mass: Int?        // in kilograms.
    let skin_color: String
    let homeworld: ResourceFetcher<Planet>
    let films: [ResourceFetcher<Film>]
    let species: [ResourceFetcher<Species>]
    let starships: [ResourceFetcher<Starship>]
    let vehicles: [ResourceFetcher<Vehicle>]

    let resourceInfo: ResourceInfo
    
    // TODO: Make this a failable initializer?
    init(dict: NSDictionary) {
        name = dict["name"] as String
        let birthStr = dict["birth_year"] as String
        if birthStr.hasSuffix("BBY") {
            let end = advance(birthStr.endIndex, -4)
            birth_year = birthStr.substringToIndex(end).toInt()
            if (birth_year != nil) { birth_year = -birth_year! }
        } else if birthStr.hasSuffix("ABY") {
            let end = advance(birthStr.endIndex, -4)
            birth_year = birthStr.substringToIndex(end).toInt()
        }
        eye_color = dict["eye_color"] as String
        gender = Gender(rawValue: dict["gender"] as String)
        hair_color = dict["hair_color"] as String
        height = (dict["height"] as String).toInt()
        mass = (dict["mass"] as String).toInt()
        skin_color = dict["skin_color"] as String
        homeworld = ResourceFetcher<Planet>(url: dict["homeworld"] as String)
        films = (dict["films"] as [String]).map { ResourceFetcher<Film>(url: $0) }
        species = (dict["species"] as [String]).map { ResourceFetcher<Species>(url: $0) }
        starships = (dict["starships"] as [String]).map { ResourceFetcher<Starship>(url: $0) }
        vehicles = (dict["vehicles"] as [String]).map { ResourceFetcher<Vehicle>(url: $0) }
        
        resourceInfo = ResourceInfo(dict: dict)
    }
    
    var description: String { return "<Person \"\(name)\" \(resourceInfo.url)>" }
}