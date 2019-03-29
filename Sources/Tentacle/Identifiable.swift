//
//  Identifiable.swift
//  Tentacle-OSX
//
//  Created by Romain Pouclet on 2017-06-18.
//  Copyright © 2017 Matt Diephouse. All rights reserved.
//

import Foundation

public protocol Identifiable: Hashable {
    var id: ID<Self> { get }
}

extension Identifiable {
    public func hash(into hasher: inout Hasher) {
        id.hash(into: &hasher)
    }
}

public struct ID<Of: Identifiable>: Decodable, Hashable {
    var rawValue: Int

    public var string: String {
        return "\(rawValue)"
    }

    public init(from decoder: Decoder) throws {
        let container = try decoder.singleValueContainer()
        rawValue = try container.decode(Int.self)
    }

}

extension ID: ExpressibleByIntegerLiteral {
    public init(integerLiteral value: Int) {
        self.rawValue = value
    }
}
