# What's this?

This is a simple Demo project which aims to demonstate the **Promises** pattern in Swift.

* It's using [PromiseKit](http://promisekit.org) (which already has a dedicated Swift API) as a Promises framework
* The demo uses the [Star Wars API](http://swapi.co) as an excuse to have a nice use-case, because querying a WebService API is asynchronous by nature and is thus a good example for showing how Promises can be useful (and because everybody loves Star Wars).

The main goal is to have functions that send requests to the API and return a `Promise` that will later be fulfilled when the server has responded.

For a very good documentation about Promises and PromiseKit, see [promisekit.org documentation](http://promisekit.org/introduction/).

## WIP

This demo is Work In Progress. So far I've not created any UI — the main goal is to demonstrate the Promise design pattern applied to Swift, not to create some fancy UI — and haven't implemented all the Model Object structures yet.

## Compatibility

This demo is expected to be run using Swift 1.1 and Xcode 6.1.x.

At the time I'm writing those lines, `PromiseKit` has not been converted to Swift 1.2 yet, but I'm eager to convert it to Swift 1.2 as soon as PromiseKit will convert its pod, so that this demo can be run within Xcode 6.3Beta.

If you want to play around with the demo, add some stuff, and need to `pod install` or `pod update` at some point, you'll need to use `CocoaPods 0.36` (which is still in beta2 at the time of that writing) or later, as earlier versions didn't support frameworks nor Swift pods.

## Model Structure

The interesting part of the demo is located in the Xcode Group named `Model`.

It describes the Model Objects like `Person`, `Planet`, `Species`, `Starship`, `Vehicle` and `Film`, some common protocol and a `ResourceURL` structure.

### The `JSONModelObject` protocol

The `JSONModelObject.swift` file contains the declaration of the `JSONModelObject` protocol and the underlying `ResourceInfo` type.

* This protocol is used as a base for any resource in the API (`Person`, `Planet`, `Species`, `Starship`, `Vehicle` and `Film`).
* As every Resource of the API has the `url`, `createdAt` and `editedAt` fields, which are more "meta-datas" than actual data describing the object, these have been embeded inside the `ResourceInfo` structure, and every resource object will have a `resourceInfo` property to describe those three fields separately, as described in the `JSONModelObject` protocol.

### The `ResourceURL<T>` class

This class is a wrapper to fetch any resource from the SW API. It encapsulate an URL / reference to a resource in the API and has the ability to fetch this resource on demand.

* You build a `ResourceURL` instance by giving it an URL, for example `ResourceURL<Person>(url: someURLToAPersonResource)`, or an ID, for example `ResourceURL<Person>(id: 5)`.
* Then you can call `fetch()` on that `ResourceURL<T>` which will send the request to its URL, parse the response as JSON, then try to build the `T` object (for example the `Person` instance) using that JSON dictionary.

As fetching the resource is intended to return a `T` object "in the future", **the `fetch()` function returns a `Promise<T>`.**

### Object RelationShips

The `ResourceURL<T>` class is mainly useful to represent when the object returned by the API contains **relationships** to other objects.

> E.g. when you query a `Starship` object from the WebService, the `pilots` field in the JSON will contain an array of URLs, each of which are pointing to the endpoint to fetch the corresponding person.

Instead of having an array of plain `Strings` in the Swift model class, I chose to represent relationships as `ResourceURL<T>`. For example a `Person` has a property `homeworld` of type `ResourceURL<Planet>`.

That way:

* The `Planet` resource is **fetched only on demand** (otherwise as the `Planet` object itself has relationships, that have relationships on their own, etc… we would end up retrieving the whole database) when you chose to call `fetch()` on it
* You know that the `homeworld` property contains URLs to a `Planet` and not an arbitrary URL to any other resource
* You can chain the calls to `fetch()` with a `then` (using Promises), and the compiler will do type chekings for you, like ensuring that the `then()` will expect the right kind of object (e.g. a `Planet`) corresponding to the `ResourceURL`.

```swift
let falcon = ResourceURL<Starship>(id: 10)
falcon.fetch().then({ ship -> Promise<Person> in
    println("Starship found: \(ship)")
    let firstPilot = ship.pilots[0] // a ResourceURL<Pilot>
    return firstPilot.fetch()
}).then({ pilot -> Promise<Planet> in
    println("Pilot found: \(pilot)")
    let homeplanet = pilot.homeworld // a ResourceURL<Planet>
    return homeplanet.fetch()
}).then({ planet in
    println("Homeworld found: \(planet)")
})
```

### Model Objects

The rest of the files (in the "Objects" Xcode subgroup) defines structures matching the resources exposed by the API, namely a struct for each of `Person`, `Planet`, `Species`, `Starship`, `Vehicle` and `Film`.

These are simple `struct` instead of classes because it's good practice in Swift to use structs for the Model layer [see Andy Matuschak's talk about that](http://realm.io/news/andy-matuschak-controlling-complexity/). 
Those structs conforms to the `JSONModelObject` protocol described above, and also to the `Printable` protocol, so that they can be dumped in the console in a user-friendly way.

## Demo App

As of now, the app does not have any UI yet. My focuse were on the model, the `ResourceURL<T>` class, and how to use `PromiseKit` in that context to have a nice API with Promises, and some sample code to use it.

The sample code used so far is in `ViewController.swift`'s `viewDidLoad()`. This will eventually be migrated into UnitTests, and I'll come up with some simple UI later. But that's not the priority, as the demo is aimed to demonstrate code and the Promises design patterns in Swift, not to create a nice-looking app.
