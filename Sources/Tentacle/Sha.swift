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

    public func encode(to encoder: Encoder) throws {
        var container = encoder.singleValueContainer()
        try container.encode(hash)
    }
}

extension SHA: ExpressibleByStringLiteral {
    public init(stringLiteral value: String) {
        self.hash = value
    }
}
