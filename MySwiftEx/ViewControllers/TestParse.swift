//
//  TestParse.swift
//  MySwiftEx
//
//  Created by codyy on 2016/12/6.
//  Copyright © 2016年 zpx. All rights reserved.
//

import Foundation
protocol Parseable {
    var dictionary: [String: AnyObject]? {get}
    func fetch<T>(_ key: String) throws ->T
    func fetchOptional<T>(_ key: String) throws -> T?
    func fetch<T, U>(_ key: String, transformation: (T)->(U?)) throws -> U
    func fetchOptional<T, U>(_ key: String, transformation: (T)->(U?)) throws -> U?
    func fetchArray<T,U>(_ key: String, transformation: (T)->(U?)) throws ->[U]
}

extension Parseable {
    func fetch<T>(_ key: String) throws -> T{
        let fetchedOptional = dictionary?[key]
        guard let fetched = fetchedOptional else {
            throw ParseError(message: "key \(key) was not found.")
        }
        guard let typed = fetched as? T else {
            throw ParseError(message: "the key \(key) was not the correct type,value is \(fetched)")
        }
        return typed
    }
    func fetchOptional<T>(_ key: String) throws -> T? {
        let fetched = dictionary?[key] as? T
        return fetched
    }
    func fetch<T, U>(_ key: String, transformation: (T)->(U?)) throws -> U {
        let fetched: T = try fetch(key)
        guard let transformed = transformation(fetched) else {
            throw ParseError(message: "The value \(fetched) at key \(key) can not be transformed")
        }
        return transformed
    }
    func fetchOptional<T, U>(_ key: String, transformation: (T)->(U?)) throws -> U? {
        let fetched: T? = try fetchOptional(key)
        return fetched.flatMap(transformation)
    }
    //for [model]
    func fetchArray<T,U>(_ key: String, transformation: (T)->(U?)) throws -> [U] {
        let fetched: [T] = try fetch(key)
        return fetched.flatMap(transformation)
    }
}

struct ParseError: Error {
    let message: String
}

/*
 struct Parse: Parseable {
    var dictionary: [String : AnyObject]?
    var name: String?
    var message: Message?
    var height: [Message]?
    init?(dictionary: [String: AnyObject]?) {
        self.dictionary = dictionary
        do {
            self.name = try fetchOptional("name")
        } catch let error {
            print(error)
        }
        do { self.message = try fetch("message") { Message(dic:$0) } } catch _ {}
        do {self.height = try fetchArray("height", transformation: { Message(dic:$0) })} catch _ {}
    }
 }
 struct Message: Parseable {
    var dictionary: [String : AnyObject]?
    var age: String?
    var classes: String?
    init?(dic: [String: AnyObject]) {
        self.dictionary = dic
        do {self.age = try fetch("age")} catch _ {}
        do {self.classes = try fetch("class")} catch _ {}
    }
 }
 */
