//
//  Request.swift
//  Tentacle
//
//  Created by Matt Diephouse on 5/19/17.
//  Copyright © 2017 Matt Diephouse. All rights reserved.
//

import Foundation

internal enum Method: String {
    case get = "GET"
    case post = "POST"
    case put = "PUT"
    case head = "HEAD"
    case options = "OPTIONS"
}

/// An opaque value representing a request to be made.
public struct Request<Value>: Hashable {
    internal var method: Method
    internal var path: String
    internal var queryItems: [URLQueryItem]
    internal var body: Data?
    
    internal init(method: Method = .get, path: String, queryItems: [URLQueryItem] = [], body: Data? = nil) {
        self.method = method
        self.path = path
        self.queryItems = queryItems
        self.body = body
    }
}
