//
//  Label.swift
//  Tentacle
//
//  Created by Romain Pouclet on 2016-05-23.
//  Copyright © 2016 Matt Diephouse. All rights reserved.
//

import Foundation

public struct Label: CustomStringConvertible, ResourceType {
    public let name: String
    public let color: Color

    public var description: String {
        return name
    }

    public init(from decoder: Decoder) throws {
        let container = try decoder.container(keyedBy: CodingKeys.self)
        self.name = try container.decode(String.self, forKey: .name)
        self.color = Color(hex: try container.decode(String.self, forKey: .color))
    }

    public init(name: String, color: Color) {
        self.name = name
        self.color = color
    }

    // TODO: remove this, or replace `Color` with something (De)codable
    private enum CodingKeys: String, CodingKey {
        case name
        case color
    }
}

extension Label: Hashable {
    public static func ==(lhs: Label, rhs: Label) -> Bool {
        return lhs.name == rhs.name
    }

    public var hashValue: Int {
        return name.hashValue
    }
}

