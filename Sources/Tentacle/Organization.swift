//
//  Organization.swift
//  Tentacle
//
//  Created by Matt Diephouse on 5/19/17.
//  Copyright © 2017 Matt Diephouse. All rights reserved.
//

import Foundation

extension Organization {
    // https://developer.github.com/v3/repos/#list-organization-repositories
    internal var repositories: Request<[RepositoryInfo]> {
        return Request(method: .get, path: "/orgs/\(name)/repos")
    }
}

/// An organization on GitHub or GitHub Enterprise.
public struct Organization: CustomStringConvertible {
    /// The organization's name.
    public let name: String
    
    public init(_ name: String) {
        self.name = name
    }
    
    public var description: String {
        return name
    }
}

extension Organization: Hashable {
    public static func ==(lhs: Organization, rhs: Organization) -> Bool {
        return lhs.name == rhs.name
    }
    
    public var hashValue: Int {
        return name.hashValue
    }
}
