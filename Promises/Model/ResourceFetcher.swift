//
//  Fetcher.swift
//  Promises
//
//  Created by Olivier Halligon on 22/02/2015.
//  Copyright (c) 2015 AliSoftware. All rights reserved.
//

import Foundation
import PromiseKit

let baseurl = "http://swapi.co/api/"

struct ResourceFetcher<T: JSONModelObject> : Printable {
    let url: String
    init(url: String) { self.url = url }
    
    func fetch() -> Promise<T> {
        return NSURLConnection.GET(self.url).then { (dict: NSDictionary) in
            let obj: T = T(dict: dict)
            return Promise<T>(value: obj)
        }
    }
    
    static func fetch(#id: Int) -> Promise<T> {
        let url = "\(baseurl)\(T.apiEndPoint)/\(id)"
        let fetcher = ResourceFetcher<T>(url: url)
        return fetcher.fetch()
    }
    
    static func fetchAll() -> Promise<[T]> {
        let url = baseurl + T.apiEndPoint
        return NSURLConnection.GET(url).then { (dict: NSDictionary) in
            let results = dict["results"] as [NSDictionary]
            let array = results.map { T(dict: $0) }
            return Promise<[T]>(value: array)
        }
    }
    
    var description: String { return "<Fetcher<\(T.apiEndPoint)> \(url)>" }
}

