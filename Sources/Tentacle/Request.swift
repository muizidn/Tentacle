//
//  Request.swift
//  Tentacle
//
//  Created by Matt Diephouse on 5/19/17.
//  Copyright © 2017 Matt Diephouse. All rights reserved.
//

import Foundation

internal struct Request<Value> {
    enum Method: String {
        case get = "GET"
        case post = "POST"
        case put = "PUT"
        case head = "HEAD"
        case options = "OPTIONS"
    }
    
    var method: Method
    var path: String
    var queryItems: [URLQueryItem]
    var body: Data?
    
    init(method: Method = .get, path: String, queryItems: [URLQueryItem] = [], body: Data? = nil) {
        self.method = method
        self.path = path
        self.queryItems = queryItems
        self.body = body
    }
}

extension Request: Hashable {
    var hashValue: Int {
        return method.hashValue
            ^ path.hashValue
            ^ queryItems.map { $0.hashValue }.reduce(0, ^)
            ^ (self.body?.hashValue ?? 0)
    }
    
    static func == (lhs: Request, rhs: Request) -> Bool {
        return lhs.method == rhs.method
            && lhs.path == rhs.path
            && lhs.queryItems == rhs.queryItems
            && lhs.body == rhs.body
    }
}
