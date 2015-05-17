//
//  JSONObjectModel.swift
//  SWPromisesDemo
//
//  Created by Olivier Halligon on 22/02/2015.
//  Copyright (c) 2015 AliSoftware. All rights reserved.
//

import Foundation

protocol JSONModelObject {
    init(dict: NSDictionary)
    
    static var apiEndPoint: String { get }
    var resourceInfo: ResourceInfo { get }
}

func parseStringList(commaSeparatedString: String) -> [String]? {
    if (commaSeparatedString == "none") { return nil }
    let spaceSet = NSCharacterSet.whitespaceAndNewlineCharacterSet()
    return commaSeparatedString.componentsSeparatedByString(",")
        .map { $0.stringByTrimmingCharactersInSet(spaceSet) }
}

struct ResourceInfo {
    let url: String
    let created: Date
    let edited: Date

    init(dict: NSDictionary) {
        url = dict["url"] as! String
        created = Date(iso8601: dict["created"] as! String)
        edited = Date(iso8601: dict["edited"] as! String)
    }
    
    var id: Int? {
        return NSURL(string: self.url)?.lastPathComponent?.toInt()
    }
}

extension ResourceInfo : Printable {
    var description: String { return "<Resource \(url)>" }
}

