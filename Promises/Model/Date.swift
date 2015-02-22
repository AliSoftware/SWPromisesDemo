//
//  Date.swift
//  Promises
//
//  Created by Olivier Halligon on 22/02/2015.
//  Copyright (c) 2015 AliSoftware. All rights reserved.
//

import Foundation

struct Date : Printable {
    let dateString: String
    
    init(iso8601: String) {
        dateString = iso8601
    }
    
    var description: String { return "<Date \(dateString)>" }
}
