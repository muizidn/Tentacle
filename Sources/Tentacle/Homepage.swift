//
//  Homepage.swift
//  Tentacle
//
//  Created by Romain Pouclet on 2017-06-20.
//  Copyright © 2017 Matt Diephouse. All rights reserved.
//

import Foundation

public enum Homepage: Decodable {
    case url(URL)
    case string(String)

    public init(from decoder: Decoder) throws {
        do {
            self = .url(try decoder.singleValueContainer().decode(URL.self))
        } catch {
            self = .string(try decoder.singleValueContainer().decode(String.self))
        }
    }
}

extension Homepage: ExpressibleByStringLiteral {
    public init(stringLiteral value: String) {
        self = .string(value)
    }
}
