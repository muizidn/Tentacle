//
//  Branch.swift
//  Tentacle
//
//  Created by Romain Pouclet on 2017-02-15.
//  Copyright © 2017 Matt Diephouse. All rights reserved.
//

import Foundation

extension Repository {
    /// A request for the branches in the repository.
    ///
    /// https://developer.github.com/v3/repos/branches/#list-branches
    public var branches: Request<[Branch]> {
        return Request(method: .get, path: "/repos/\(owner)/\(name)/branches")
    }
}

public struct Branch: ResourceType {

    public struct Commit: Decodable {
        public let sha: SHA
    }

    /// Name of the branch
    public let name: String

    /// The commit the branch points to
    public let commit: Commit

    public init(name: String, commit: Commit) {
        self.name = name
        self.commit = commit
    }

}

extension Branch: Hashable {
    public static func ==(lhs: Branch, rhs: Branch) -> Bool {
        return lhs.name == rhs.name && lhs.commit == rhs.commit
    }

    public var hashValue: Int {
        return name.hashValue ^ commit.hashValue
    }
}

extension Branch.Commit: Hashable {
    public var hashValue: Int {
        return sha.hashValue
    }
}

extension Branch.Commit: Equatable {
    public static func ==(lhs: Branch.Commit, rhs: Branch.Commit) -> Bool {
        return lhs.sha == rhs.sha
    }
}
