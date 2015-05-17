//
//  ResourceURL.swift
//  SWPromisesDemo
//
//  Created by Olivier Halligon on 22/02/2015.
//  Copyright (c) 2015 AliSoftware. All rights reserved.
//

import Foundation
import PromiseKit

let baseurl = "http://swapi.co/api/"

// TODO: Once Swift adds support for static variables in generic types
// we should migrate this as a static var inside ResourceURL<T> (and change type to [String:T])
private var resourceURLCache = [String:JSONModelObject]()

struct ResourceURL<T: JSONModelObject> {
    let url: String
    
    init(url: String) { self.url = url }
    init(id: Int) { self.url = "\(baseurl)\(T.apiEndPoint)/\(id)/" }

    var cachedObject: T? {
        return resourceURLCache[self.url] as! T?
    }
    
    func fetch(useCache: Bool = true) -> Promise<T> {
        if useCache {
            if let object = cachedObject {
                return Promise<T>(object as T)
            }
        }
        return NSURLConnection.GET(self.url).then { (dict: NSDictionary) in
            let obj: T = T(dict: dict)
            resourceURLCache[self.url] = obj
            return Promise<T>(obj)
        }
    }
    
    static func fetch(#id: Int, useCache: Bool = true) -> Promise<T> {
        let rsrcURL = ResourceURL<T>(id: id)
        return rsrcURL.fetch(useCache: useCache)
    }
    
    static func fetchAll(page: Int = 1) -> Promise<(list:[T], hasNext:Bool)> {
        let url = baseurl + T.apiEndPoint + "/?page=\(page)"
        return NSURLConnection.GET(url).then { (dict: NSDictionary) in
            let results = dict["results"] as! [NSDictionary]
            let array = results.map { T(dict: $0) }
            for obj in array { resourceURLCache[obj.resourceInfo.url] = obj }
            let hasNext = dict["next"] != nil
            return Promise<(list:[T], hasNext:Bool)>((list: array, hasNext: hasNext))
        }
    }
}

extension ResourceURL : Printable {
    var description: String { return "<Resource \(url)>" }
}

