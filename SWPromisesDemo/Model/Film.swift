//
//  Film.swift
//  SWPromisesDemo
//
//  Created by Olivier Halligon on 22/02/2015.
//  Copyright (c) 2015 AliSoftware. All rights reserved.
//

import Foundation

struct Film : JSONModelObject {
    static var apiEndPoint: String { return "films" }
    let resourceInfo: ResourceInfo
    
    let title: String
    let episode_id: Int
    let opening_crawl: String
    let director: String
    let producer: [String]
    let species: [ResourceURL<Species>]
    let starships: [ResourceURL<Starship>]
    let vehicles: [ResourceURL<Vehicle>]
    let characters: [ResourceURL<Person>]
    let planets: [ResourceURL<Planet>]
    
    init(dict: NSDictionary) {
        title = dict["title"] as String
        episode_id = dict["episode_id"] as Int
        opening_crawl = dict["opening_crawl"] as String
        director = dict["director"] as String
        producer = parseStringList(dict["director"] as String)!
        species = (dict["species"] as [String]).map { ResourceURL<Species>(url: $0) }
        starships = (dict["starships"] as [String]).map { ResourceURL<Starship>(url: $0) }
        vehicles = (dict["vehicles"] as [String]).map { ResourceURL<Vehicle>(url: $0) }
        characters = (dict["characters"] as [String]).map { ResourceURL<Person>(url: $0) }
        planets = (dict["planets"] as [String]).map { ResourceURL<Planet>(url: $0) }
        
        resourceInfo = ResourceInfo(dict: dict)
    }
}

extension Film : Printable {
    var description: String {
        return "<Film #\(resourceInfo.id!): Ep.\(episode_id) - \(title)>"
    }
}
