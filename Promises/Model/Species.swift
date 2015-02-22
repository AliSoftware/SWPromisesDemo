//
//  Species.swift
//  Promises
//
//  Created by Olivier Halligon on 22/02/2015.
//  Copyright (c) 2015 AliSoftware. All rights reserved.
//

import Foundation

struct Species : JSONModelObject, Printable {
    static var apiEndPoint: String { return "species" }
    
    let url: String
    let created: Date
    let edited: Date
    
    init(dict: NSDictionary) {
        url = dict["url"] as String
        created = Date(iso8601: dict["created"] as String)
        edited = Date(iso8601: dict["edited"] as String)
    }
    
    var description: String { return "<Species \(url)>" }
}
