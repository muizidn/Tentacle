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

        public enum EntryType {
            case blob(url: URL, size: Int)
            case tree(url: URL)
            case commit
        }

        public enum Mode: String {
            case file = "100644"
            case executable = "100755"
            case subdirectory = "040000"
            case submodule = "160000"
            case symlink = "120000"
        }

        /// The type of the entry.
        public let type: EntryType

        /// The SHA of the entry.
        public let sha: SHA

        /// The repository-relative path of the entry.
        public let path: String

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
            <^> Tree.Entry.EntryType.decode(j)
            <*> (j <| "sha" >>- toSHA)
            <*> j <| "path"
            <*> j <| "mode"
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

func decodeBlob(_ j: JSON) -> Decoded<Tree.Entry.EntryType> {
    return curry(Tree.Entry.EntryType.blob)
        <^> j <| "url"
        <*> j <| "size"
}

func decodeTree(_ j: JSON) -> Decoded<Tree.Entry.EntryType> {
    return curry(Tree.Entry.EntryType.tree)
        <^> j <| "url"
}

extension Tree.Entry.EntryType: Decodable {
    public static func decode(_ json: JSON) -> Decoded<Tree.Entry.EntryType> {
        guard case let .object(payload) = json else {
            return .failure(.typeMismatch(expected: "object", actual: "\(json)"))
        }

        guard let type = payload["type"], case let .string(value) = type else {
            return .failure(.custom("Content type is invalid"))
        }

        switch value {
        case "blob":
            return decodeBlob(json)
        case "commit":
            return .success(Tree.Entry.EntryType.commit)
        case "tree":
            return decodeTree(json)
        default:
            return .failure(.custom("Content type \(value) is invalid"))
        }
    }
}

extension Tree.Entry.Mode: Decodable {}
