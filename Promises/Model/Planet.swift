//
//  Planet.swift
//  Promises
//
//  Created by Olivier Halligon on 22/02/2015.
//  Copyright (c) 2015 AliSoftware. All rights reserved.
//

import Foundation

struct Planet : JSONModelObject, Printable {
    static var apiEndPoint: String { return "planets" }
    
    let resourceInfo: ResourceInfo
    
    init(dict: NSDictionary) {
        resourceInfo = ResourceInfo(dict: dict)
    }
    
    var description: String { return "<Planet \(resourceInfo.url)>" }
}
