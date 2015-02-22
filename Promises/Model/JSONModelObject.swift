//
//  JSONObjectModel.swift
//  Promises
//
//  Created by Olivier Halligon on 22/02/2015.
//  Copyright (c) 2015 AliSoftware. All rights reserved.
//

import Foundation

protocol JSONModelObject {
    init(dict: NSDictionary)
    
    class var apiEndPoint: String { get }
    var resourceInfo: ResourceInfo { get }
}

struct ResourceInfo {
    let url: String
    let created: Date
    let edited: Date

    init(dict: NSDictionary) {
        url = dict["url"] as String
        created = Date(iso8601: dict["created"] as String)
        edited = Date(iso8601: dict["edited"] as String)
    }
    
    var id: Int? {
        return NSURL(string: self.url)?.lastPathComponent?.toInt()
    }
}

extension ResourceInfo : Printable {
    var description: String { return "<Resource \(url)>" }
}

