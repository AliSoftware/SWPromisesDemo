//
//  Species.swift
//  Promises
//
//  Created by Olivier Halligon on 22/02/2015.
//  Copyright (c) 2015 AliSoftware. All rights reserved.
//

import Foundation

struct Species : JSONModelObject, Printable {
    static var apiPoint: String { return "species" }
    
    let url: String
    
    init(dict: NSDictionary) {
        url = dict["url"] as String
    }
    
    var description: String { return "<Species \(url)>" }
}
