//
//  Film.swift
//  SWPromisesDemo
//
//  Created by Olivier Halligon on 22/02/2015.
//  Copyright (c) 2015 AliSoftware. All rights reserved.
//

import Foundation

struct Film : JSONModelObject, Printable {
    static var apiEndPoint: String { return "films" }
    let resourceInfo: ResourceInfo
    
    init(dict: NSDictionary) {
        resourceInfo = ResourceInfo(dict: dict)
    }

    var description: String { return "<Film #\(resourceInfo.id!)>" }
}
