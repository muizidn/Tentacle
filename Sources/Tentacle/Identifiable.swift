//
//  Identifiable.swift
//  Tentacle-OSX
//
//  Created by Romain Pouclet on 2017-06-18.
//  Copyright © 2017 Matt Diephouse. All rights reserved.
//

import Foundation

public protocol Identifiable {
    var id: ID<Self> { get }
}

public struct ID<Of: Identifiable> {
    let rawValue: Int
}

extension ID: ExpressibleByIntegerLiteral {
    public init(integerLiteral value: Int) {
        self.rawValue = value
    }
}

extension ID: Hashable {

    public var hashValue: Int {
        return rawValue.hashValue
    }

}

extension ID: Equatable {

    static public func == (lhs: ID, rhs: ID) -> Bool {
        return lhs.rawValue == rhs.rawValue
    }
    
}
