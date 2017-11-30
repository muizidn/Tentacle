//
//  Repository.swift
//  Tentacle
//
//  Created by Matt Diephouse on 3/3/16.
//  Copyright © 2016 Matt Diephouse. All rights reserved.
//

import Foundation

extension Repository {
    
    /// A request for the repository's Info
    ///
    /// https://developer.github.com/v3/repos/#get
    public var info: Request<RepositoryInfo> {
        return Request(method: .get, path: "/repos/\(owner)/\(name)")
    }

}


/// A GitHub.com or GitHub Enterprise repository.
public struct Repository: CustomStringConvertible {
    public let owner: String
    public let name: String
    
    public init(owner: String, name: String) {
        self.owner = owner
        self.name = name
    }
    
    public var description: String {
        return "\(owner)/\(name)"
    }
}

extension Repository: Hashable {
    public static func ==(lhs: Repository, rhs: Repository) -> Bool {
        return lhs.owner.caseInsensitiveCompare(rhs.owner) == .orderedSame
            && lhs.name.caseInsensitiveCompare(rhs.name) == .orderedSame
    }

    public var hashValue: Int {
        return description.lowercased().hashValue
    }
}
