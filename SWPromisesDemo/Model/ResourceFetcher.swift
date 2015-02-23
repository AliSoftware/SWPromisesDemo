//
//  Fetcher.swift
//  SWPromisesDemo
//
//  Created by Olivier Halligon on 22/02/2015.
//  Copyright (c) 2015 AliSoftware. All rights reserved.
//

import Foundation
import PromiseKit

let baseurl = "http://swapi.co/api/"

private var resourceFetcherCache = [String:JSONModelObject]()

struct ResourceFetcher<T: JSONModelObject> {
    let url: String
    init(url: String) { self.url = url }

    func fetch(useCache: Bool = true) -> Promise<T> {
        if useCache {
            let cachedObject = resourceFetcherCache[self.url]
            if let object = cachedObject {
//                println(">>> Used cache for \(self.url)!")
                return Promise<T>(value: object as T)
            }
        }
        return NSURLConnection.GET(self.url).then { (dict: NSDictionary) in
            let obj: T = T(dict: dict)
            resourceFetcherCache[self.url] = obj
            return Promise<T>(value: obj)
        }
    }
    
    static func fetch(#id: Int, useCache: Bool = true) -> Promise<T> {
        let url = "\(baseurl)\(T.apiEndPoint)/\(id)/"
        let fetcher = ResourceFetcher<T>(url: url)
        return fetcher.fetch(useCache: useCache)
    }
    
    static func fetchAll() -> Promise<[T]> {
        let url = baseurl + T.apiEndPoint
        return NSURLConnection.GET(url).then { (dict: NSDictionary) in
            let results = dict["results"] as [NSDictionary]
            let array = results.map { T(dict: $0) }
            for obj in array { resourceFetcherCache[obj.resourceInfo.url] = obj }
            return Promise<[T]>(value: array)
        }
    }
}

extension ResourceFetcher : Printable {
    var description: String { return "<Resource \(url)>" }
}

