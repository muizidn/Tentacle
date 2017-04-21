//
//  Tree.swift
//  Tentacle
//
//  Created by David Caunt on 21/04/2017.
//  Copyright © 2017 Matt Diephouse. All rights reserved.
//

import Foundation
import Argo
import Curry
import Runes

public struct Tree: CustomStringConvertible {

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

    public struct Entry {

        public enum EntryType: String {
            case blob
            case tree
            case commit
        }

        public enum Mode: String {
            case file = "100644"
            case executable = "100755"
            case subdirectory = "040000"
            case submodule = "160000"
            case symlink = "120000"
        }

        /// The SHA of the entry.
        public let sha: SHA

        /// The repository-relative path of the entry.
        public let path: String

        /// The URL for the entry.
        public let url: URL

        /// The type of the entry.
        public let type: EntryType

        /// The mode of the entry.
        public let mode: Mode
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

extension Tree: ResourceType {
    public static func decode(_ j: JSON) -> Decoded<Tree> {
        return curry(self.init)
            <^> (j <| "sha" >>- toSHA)
            <*> (j <| "url" >>- toURL)
            <*> j <|| "tree"
            <*> j <| "truncated"
    }
}

extension Tree.Entry: ResourceType {
    public static func decode(_ j: JSON) -> Decoded<Tree.Entry> {
        return curry(self.init)
            <^> (j <| "sha" >>- toSHA)
            <*> j <| "path"
            <*> (j <| "url" >>- toURL)
            <*> (j <| "type" >>- toTreeEntryType)
            <*> (j <| "mode" >>- toTreeEntryMode)
    }
}

extension Tree.Entry: Hashable {
    public static func ==(lhs: Tree.Entry, rhs: Tree.Entry) -> Bool {
        return lhs.sha == rhs.sha
            && lhs.url == rhs.url
            && lhs.path == rhs.path
            && lhs.type == rhs.type
            && lhs.mode == rhs.mode
    }

    public var hashValue: Int {
        return sha.hashValue
    }
}
