//
//  Author.swift
//  Tentacle
//
//  Created by Romain Pouclet on 2016-12-22.
//  Copyright © 2016 Matt Diephouse. All rights reserved.
//

import Foundation

public struct Author: ResourceType {
    /// Name of the Author
    let name: String
    /// Email of the Author
    let email: String

    public init(name: String, email: String) {
        self.name = name
        self.email = email
    }
}

extension Author: Encodable {
    public func encode(to encoder: Encoder) throws {
        var container = encoder.container(keyedBy: CodingKeys.self)
        try container.encode(name, forKey: .name)
        try container.encode(email, forKey: .email)
    }
}

extension Author: Hashable, Equatable {
    public var hashValue: Int {
        return name.hashValue ^ email.hashValue
    }

    static public func ==(lhs: Author, rhs: Author) -> Bool {
        return lhs.name == rhs.name
            && lhs.email == rhs.email
    }
}
