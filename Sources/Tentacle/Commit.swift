//
//  Commit.swift
//  Tentacle
//
//  Created by Romain Pouclet on 2016-12-22.
//  Copyright © 2016 Matt Diephouse. All rights reserved.
//

import Foundation

public struct Commit: ResourceType {
    public struct Hash: Decodable {
        let raw: String

        public init(from decoder: Decoder) throws {
            let container = try decoder.singleValueContainer()
            self.raw = try container.decode(String.self)
        }
    }

    /// SHA of the commit
    public let sha: Hash

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
        public let sha: Hash
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

extension Commit {
    public var hashValue: Int {
        return sha.hashValue
    }

    public static func ==(lhs: Commit, rhs: Commit) -> Bool {
        return lhs.sha == rhs.sha
    }
}

extension Commit.Author {
    public var hashValue: Int {
        return date.hashValue ^ name.hashValue ^ email.hashValue
    }

    public static func ==(lhs: Commit.Author, rhs: Commit.Author) -> Bool {
        return lhs.date == rhs.date
            && lhs.name == rhs.name
            && lhs.email == rhs.email
    }
}

extension Commit.Parent {
    public var hashValue: Int {
        return sha.hashValue ^ url.hashValue
    }

    public static func ==(lhs: Commit.Parent, rhs: Commit.Parent) -> Bool {
        return lhs.sha == rhs.sha
            && lhs.url == rhs.url
    }
}

extension Commit.Hash: Hashable {
    public var hashValue: Int {
        return self.raw.hashValue
    }
}

extension Commit.Hash: Equatable {
    public static func ==(lhs: Commit.Hash, rhs: Commit.Hash) -> Bool {
        return lhs.raw == rhs.raw
    }
}

extension Commit.Hash: ExpressibleByStringLiteral {
    public init(stringLiteral value: String) {
        self.raw = value
    }

}
