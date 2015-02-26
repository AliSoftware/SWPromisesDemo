//
//  Person.swift
//  SWPromisesDemo
//
//  Created by Olivier Halligon on 22/02/2015.
//  Copyright (c) 2015 AliSoftware. All rights reserved.
//

import Foundation
import PromiseKit

enum Gender : String {
    case Male = "male"
    case Female = "female"
    case Unknown = "unknown"
}


struct Person : JSONModelObject {
    static var apiEndPoint: String { return "people" }
    let resourceInfo: ResourceInfo
    
    let name: String
    let birth_year: Int      // Relative to the Battle of Yavin (Star Wars episode IV: A New Hope)
    let eye_color: String?   // nil if not available
    let gender: Gender?      // nil if not available
    let hair_color: String?  // nil if not available
    let height: Int          // in centimeters.
    let mass: Int            // in kilograms.
    let skin_color: String?  // nil if unknown
    let homeworld: ResourceURL<Planet>
    let films: [ResourceURL<Film>]
    let species: [ResourceURL<Species>]
    let starships: [ResourceURL<Starship>]
    let vehicles: [ResourceURL<Vehicle>]

    
    // TODO: Make this a failable initializer?
    init(dict: NSDictionary) {
        name = dict["name"] as String
        let birthStr = dict["birth_year"] as String
        if birthStr.hasSuffix("BBY") {
            let end = advance(birthStr.endIndex, -3)
            let year = birthStr.substringToIndex(end).toInt()!
            birth_year = -year
        } else if birthStr.hasSuffix("ABY") {
            let end = advance(birthStr.endIndex, -3)
            birth_year = birthStr.substringToIndex(end).toInt()!
        } else {
            birth_year = 0
        }
        
        func naToNil(string: String) -> String? {
            return ((string.lowercaseString == "n/a") || (string.lowercaseString == "unknown")) ? nil : string
        }
        eye_color = naToNil(dict["eye_color"] as String)
        gender = Gender(rawValue: (dict["gender"] as String).lowercaseString)
        hair_color = naToNil(dict["hair_color"] as String)
        height = (dict["height"] as String).toInt()!
        mass = (dict["mass"] as String).toInt()!
        skin_color = naToNil(dict["skin_color"] as String)
        homeworld = ResourceURL<Planet>(url: dict["homeworld"] as String)
        films = (dict["films"] as [String]).map { ResourceURL<Film>(url: $0) }
        species = (dict["species"] as [String]).map { ResourceURL<Species>(url: $0) }
        starships = (dict["starships"] as [String]).map { ResourceURL<Starship>(url: $0) }
        vehicles = (dict["vehicles"] as [String]).map { ResourceURL<Vehicle>(url: $0) }
        
        resourceInfo = ResourceInfo(dict: dict)
    }
}

extension Person : Printable {
    var description: String {
        let birth = (birth_year < 0) ? "\(birth_year) BBY" : "\(birth_year) ABY"
        let genderString = gender?.rawValue ?? "N/A"
        return "<Person #\(resourceInfo.id!): \(name) (\(genderString)), born in \(birth) on \(homeworld)>"
    }
}