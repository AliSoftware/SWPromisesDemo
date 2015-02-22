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
    static var apiPoint: String { return "people" }
    
    let name: String // The name of this person.
    let birth_year: Int? // The birth year of the person, using the in-universe standard of BBY or ABY - Before the Battle of Yavin or After the Battle of Yavin. The Battle of Yavin is a battle that occurs at the end of Star Wars episode IV: A New Hope.
    let eye_color: String // The eye color of this person. Will be "unknown" if not known or "n/a" if the person does not have an eye.
    let gender: Gender? // The gender of this person. Either "Male", "Female" or "unknown", "n/a" if the person does not have a gender.
    let hair_color: String // The hair color of this person. Will be "unknown" if not known or "n/a" if the person does not have hair.
    let height: Int? // The height of the person in centimeters.
    let mass: Int? // The mass of the person in kilograms.
    let skin_color: String // The skin color of this person.
    let homeworld: Fetcher<Planet> // The URL of a planet resource, a planet that this person was born on or inhabits.
    let films: [Fetcher<Film>] // An array of film resource URLs that this person has been in.
    let species: [Fetcher<Species>] // An array of species resource URLs that this person belonds to.
    let starships: [Fetcher<Starship>] // An array of starship resource URLs that this person has piloted.
    let vehicles: [Fetcher<Vehicle>] // An array of vehicle resource URLs that this person has piloted.
    let url: String // the hypermedia URL of this resource.
    let created: Date // the ISO 8601 date format of the time that this resource was created.
    let edited: Date // the ISO 8601 date format of the time that this resource was edited.
    
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
        homeworld = Fetcher<Planet>(url: dict["homeworld"] as String)
        films = (dict["films"] as [String]).map { Fetcher<Film>(url: $0) }
        species = (dict["species"] as [String]).map { Fetcher<Species>(url: $0) }
        starships = (dict["starships"] as [String]).map { Fetcher<Starship>(url: $0) }
        vehicles = (dict["vehicles"] as [String]).map { Fetcher<Vehicle>(url: $0) }
        url = dict["url"] as String
        created = Date(iso8601: dict["created"] as String)
        edited = Date(iso8601: dict["edited"] as String)
    }
    
    var description: String { return "<Person \"\(name)\" \(url)>" }
}