//
//  Sha.swift
//  Tentacle
//
//  Created by Romain Pouclet on 2016-12-26.
//  Copyright © 2016 Matt Diephouse. All rights reserved.
//

import Foundation

public struct SHA: ResourceType, Encodable {
    public let hash: String

    public init(from decoder: Decoder) throws {
        let container = try decoder.singleValueContainer()
        self.hash = try container.decode(String.self)
    }

}

extension SHA {
    public var hashValue: Int {
        return hash.hashValue
    }

    public static func ==(lhs: SHA, rhs: SHA) -> Bool {
        return lhs.hash == rhs.hash
    }
}

extension SHA: ExpressibleByStringLiteral {
    public init(stringLiteral value: String) {
        self.hash = value
    }
}
