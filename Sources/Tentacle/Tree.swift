//
//  Tree.swift
//  Tentacle
//
//  Created by David Caunt on 21/04/2017.
//  Copyright © 2017 Matt Diephouse. All rights reserved.
//

import Foundation

extension Repository {
    /// A request for a tree in the repository.
    ///
    /// https://developer.github.com/v3/git/trees/#get-a-tree
    public func tree(atRef ref: String = "HEAD", recursive: Bool = false) -> Request<Tree> {
        let queryItems: [URLQueryItem]
        if recursive {
            queryItems = [ URLQueryItem(name: "recursive", value: "1") ]
        } else {
            queryItems = []
        }
        return Request(method: .get, path: "repos/\(owner)/\(name)/git/trees/\(ref)", queryItems: queryItems)
    }
    
    /// A request to create a tree in the repository.
    ///
    /// https://developer.github.com/v3/git/trees/#create-a-tree
    public func create(tree: [Tree.Entry], basedOn base: String?) -> Request<FileResponse> {
        let object = NewTree(entries: tree, base: base)

        let encoder = JSONEncoder()
        let payload = try? encoder.encode(object)
        return Request(method: .post, path: "repos/\(owner)/\(name)/git/trees", body: payload)
    }
}

public struct Tree: CustomStringConvertible, ResourceType {

    /// The SHA of the entry.
    public let sha: SHA

    /// The URL for the tree.
    public let url: URL

    /// The entries under this tree.
    public let entries: [Entry]

    /// Whether the number of entries in this tree exceeded the maximum number 
    /// which will be returned by the API.
    public let isTruncated: Bool

    public var description: String {
        return "\(url)"
    }

    private enum CodingKeys: String, CodingKey {
        case sha
        case url
        case entries = "tree"
        case isTruncated = "truncated"
    }

    public struct SHA: Codable {
        public let hash: String

        public init(from decoder: Decoder) throws {
            self.hash = try decoder.singleValueContainer().decode(String.self)
        }

        public func encode(to encoder: Encoder) throws {
            var container = encoder.singleValueContainer()
            try container.encode(hash)
        }
    }

    public struct Entry: ResourceType, Encodable {

        public enum EntryType: ResourceType, Encodable {
            case blob(url: URL, size: Int)
            case tree(url: URL)
            case commit

            public init(from decoder: Decoder) throws {
                let container = try decoder.container(keyedBy: CodingKeys.self)
                let type = try container.decode(String.self, forKey: .type)

                switch type {
                case "blob":
                    let url = try container.decode(URL.self, forKey: .url)
                    let size = try container.decode(Int.self, forKey: .size)
                    self = .blob(url: url, size: size)
                case "commit":
                    self = .commit
                case "tree":
                    let url = try container.decode(URL.self, forKey: .url)
                    self = .tree(url: url)
                default:
                    throw DecodingError.dataCorrupted(DecodingError.Context(
                        codingPath: container.codingPath + [CodingKeys.type],
                        debugDescription: "Unexpected type \(type)"
                    ))
                }
            }

            private enum CodingKeys: String, CodingKey {
                case type
                case url
                case size
            }

            public func encode(to encoder: Encoder) throws {
                var container = encoder.singleValueContainer()
                switch self {
                case .blob: try container.encode("blob")
                case .tree: try container.encode("tree")
                case .commit: try container.encode("commit")
                }
            }
        }

        public enum Mode: String, ResourceType, Encodable {
            case file = "100644"
            case executable = "100755"
            case subdirectory = "040000"
            case submodule = "160000"
            case symlink = "120000"

            public func encode(to encoder: Encoder) throws {
                var container = encoder.singleValueContainer()
                try container.encode(rawValue)
            }

        }

        /// The type of the entry.
        public let type: EntryType

        /// The SHA of the entry.
        public let sha: SHA

        /// The repository-relative path of the entry.
        public let path: String

        /// The mode of the entry.
        public let mode: Mode

        public init(from decoder: Decoder) throws {
            let container = try decoder.container(keyedBy: CodingKeys.self)
            self.sha = try container.decode(SHA.self, forKey: .sha)
            self.path = try container.decode(String.self, forKey: .path)
            self.mode = try container.decode(Mode.self, forKey: .mode)
            self.type = try EntryType(from: decoder)
        }

        public init(type: EntryType, sha: SHA, path: String, mode: Mode) {
            self.type = type
            self.sha = sha
            self.path = path
            self.mode = mode
        }

        private enum CodingKeys: String, CodingKey {
            case type
            case sha
            case path
            case mode
            case url
            case size
        }

        public func encode(to encoder: Encoder) throws {
            var container = encoder.container(keyedBy: CodingKeys.self)
            try container.encode(type, forKey: .type)
            try container.encode(path, forKey: .path)
            try container.encode(sha, forKey: .sha)
            try container.encode(mode, forKey: .mode)

            switch type {
            case let .blob(url: url, size: size):
                try container.encode(url, forKey: .url)
                try container.encode(size, forKey: .size)
            case let .tree(url: url):
                try container.encode(url, forKey: .url)
            default: break
            }
        }
    }
}

extension Tree: Hashable {
    public static func ==(lhs: Tree, rhs: Tree) -> Bool {
        return lhs.sha == rhs.sha
            && lhs.url == rhs.url
            && lhs.entries == rhs.entries
            && lhs.isTruncated == rhs.isTruncated
    }

    public var hashValue: Int {
        return sha.hashValue
    }
}

extension Tree.Entry.EntryType: Hashable, Equatable {
    public var hashValue: Int {
        switch self {
        case let .blob(url: url, size: size):
            return "blob".hashValue ^ url.hashValue ^ size.hashValue
        case let .tree(url):
            return "tree".hashValue ^ url.hashValue
        case .commit:
            return "commit".hashValue
        }
    }

    static public func ==(lhs: Tree.Entry.EntryType, rhs: Tree.Entry.EntryType) -> Bool {
        switch (lhs, rhs) {
        case let (.blob(url1, size1), .blob(url2, size2)):
            return url1 == url2 && size1 == size2
        case let (.tree(url1), .tree(url2)):
            return url1 == url2
        case (.commit, .commit):
            return true
        default:
            return false
        }
    }
}

extension Tree.Entry: Hashable {
    public static func ==(lhs: Tree.Entry, rhs: Tree.Entry) -> Bool {
        return lhs.sha == rhs.sha
    }

    public var hashValue: Int {
        return sha.hashValue
    }
}

extension Tree.SHA: ExpressibleByStringLiteral {
    public init(stringLiteral value: String) {
        self.hash = value
    }
}

extension Tree.SHA: Equatable {
    public static func ==(lhs: Tree.SHA, rhs: Tree.SHA) -> Bool {
        return lhs.hash == rhs.hash
    }
}

extension Tree.SHA: Hashable {
    public var hashValue: Int {
        return hash.hashValue
    }
}

internal struct NewTree: Encodable {
    /// The entries under this tree.
    internal let entries: [Tree.Entry]

    /// The base for the new tree.
    internal let base: String?

    internal enum CodingKeys: String, CodingKey {
        case entries = "tree"
        case base = "base_tree"
    }

    func encode(to encoder: Encoder) throws {
        var container = encoder.container(keyedBy: CodingKeys.self)
        try container.encode(entries, forKey: .entries)

        if let base = base {
            try container.encode(base, forKey: .base)
        }
    }
}
