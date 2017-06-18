//
//  Sha.swift
//  Tentacle
//
//  Created by Romain Pouclet on 2016-12-26.
//  Copyright © 2016 Matt Diephouse. All rights reserved.
//

import Foundation

public struct SHA: ResourceType {
    public let hash: String

    private enum CodingKeys: String, CodingKey {
        case hash = "sha"
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

