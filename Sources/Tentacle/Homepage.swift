//
//  Homepage.swift
//  Tentacle
//
//  Created by Romain Pouclet on 2017-06-20.
//  Copyright © 2017 Matt Diephouse. All rights reserved.
//

import Foundation

public struct Homepage: Decodable {
    let raw: String

    public var url: URL? {
        return URL(string: raw)
    }

    public init(from decoder: Decoder) throws {
        raw = try decoder.singleValueContainer().decode(String.self)
    }
}

extension Homepage: ExpressibleByStringLiteral {
    public init(stringLiteral value: String) {
        self.raw = value
    }
}
