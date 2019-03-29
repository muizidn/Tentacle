//
//  Commit.swift
//  Tentacle
//
//  Created by Romain Pouclet on 2016-12-22.
//  Copyright © 2016 Matt Diephouse. All rights reserved.
//

import Foundation

public struct Commit: ResourceType {
    /// SHA of the commit
    public let sha: SHA

    /// Author of the commit
    public let author: Author

    /// Committer of the commit
    public let committer: Author

    /// Comit Message
    public let message: String

    /// URL to see the commit in a browser
    public let url: URL

    /// Parents commits
    public let parents: [Parent]

    public struct Parent: ResourceType {
        /// URL to see the parent commit in a browser
        public let url: URL

        /// SHA of the parent commit
        public let sha: SHA
    }

    public struct Author: ResourceType {
        /// Date the author made the commit
        public let date: Date
        /// Name of the author
        public let name: String
        /// Email of the author
        public let email: String
    }
}

extension Commit: Hashable {
    public func hash(into hasher: inout Hasher) {
        sha.hash(into: &hasher)
    }

    public static func ==(lhs: Commit, rhs: Commit) -> Bool {
        return lhs.sha == rhs.sha
    }
}
