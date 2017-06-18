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

public struct ID<Of: Identifiable>: Decodable {
    var rawValue: Int

    public var string: String {
        return "\(rawValue)"
    }

    public init(from decoder: Decoder) throws {
        let container = try decoder.singleValueContainer()
        rawValue = try container.decode(Int.self)
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
