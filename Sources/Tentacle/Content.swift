//
//  Content.swift
//  Tentacle
//
//  Created by Romain Pouclet on 2016-11-28.
//  Copyright © 2016 Matt Diephouse. All rights reserved.
//

import Foundation

extension Repository {
    /// A request for the content at a given path in the repository.
    ///
    /// https://developer.github.com/v3/repos/contents/#get-contents
    public func content(atPath path: String, atRef ref: String? = nil) -> Request<Content> {
        let queryItems: [URLQueryItem]
        if let ref = ref {
            queryItems = [ URLQueryItem(name: "ref", value: ref) ]
        } else {
            queryItems = []
        }
        return Request(method: .get, path: "/repos/\(owner)/\(name)/contents/\(path)", queryItems: queryItems)
    }
}

/// Content
/// https://developer.github.com/v3/repos/contents/
///
/// - file: a file when queried directly in a repository
/// - directory: a directory when queried directly in a repository (may contain multiple files)
public enum Content: ResourceType {
    /// A file in a repository
    public struct File: CustomStringConvertible, Decodable {

        /// Type of content in a repository
        ///
        /// - file: a file in a repository
        /// - directory: a directory in a repository
        /// - symlink: a symlink in a repository not targeting a file inside the same repository
        /// - submodule: a submodule in a repository
        public enum ContentType: Decodable {
            /// A file a in a repository
            case file(size: Int, downloadURL: URL?)

            /// A directory in a repository
            case directory

            /// A symlink in a repository. Target and URL are optional because they are treated as regular files
            /// when they are the result of a query for a directory
            /// See https://developer.github.com/v3/repos/contents/
            case symlink(target: String?, downloadURL: URL?)

            /// A submodule in a repository. URL is optional because they are treated as regular files
            /// when they are the result of a query for a directory
            /// See https://developer.github.com/v3/repos/contents/
            case submodule(url: String?)

            public init(from decoder: Decoder) throws {
                let container = try decoder.container(keyedBy: CodingKeys.self)
                let type = try container.decode(String.self, forKey: .type)
                switch type {
                case "file":
                    let size = try container.decode(Int.self, forKey: .size)
                    if let url = try container.decodeIfPresent(URL.self, forKey: .downloadURL) {
                        self = .file(size: size, downloadURL: url)
                    } else {
                        self = .submodule(url: nil)
                    }
                case "dir":
                    self = .directory
                case "submodule":
                    let url = try container.decodeIfPresent(String.self, forKey: .submoduleURL)
                    self = .submodule(url: url)
                case "symlink":
                    let target = try container.decodeIfPresent(String.self, forKey: .target)
                    let url = try container.decodeIfPresent(URL.self, forKey: .downloadURL)
                    self = .symlink(target: target, downloadURL: url)
                default:
                    throw DecodingError.dataCorrupted(DecodingError.Context(
                        codingPath: container.codingPath + [CodingKeys.type],
                        debugDescription: "Invalid content-type \(type)"
                    ))
                }
            }

            private enum CodingKeys: String, CodingKey {
                case type
                case size
                case target
                case downloadURL = "download_url"
                case submoduleURL = "submodule_git_url"
            }
        }

        /// The type of content
        public let content: ContentType

        /// Name of the file
        public let name: String

        /// Path to the file in repository
        public let path: String

        /// Sha of the file
        public let sha: String

        /// URL to preview the content
        public let url: URL

        public var description: String {
            return name
        }

        public init(from decoder: Decoder) throws {
            let container = try decoder.container(keyedBy: CodingKeys.self)

            self.name = try container.decode(String.self, forKey: .name)
            self.path = try container.decode(String.self, forKey: .path)
            self.sha = try container.decode(String.self, forKey: .sha)
            self.url = try container.decode(URL.self, forKey: .url)
            self.content = try ContentType(from: decoder)
        }

        public init(content: ContentType, name: String, path: String, sha: String, url: URL) {
            self.name = name
            self.path = path
            self.sha = sha
            self.url = url
            self.content = content
        }

        private enum CodingKeys: String, CodingKey {
            case name
            case path
            case sha
            case url = "html_url"
            case content
        }

    }

    case file(File)
    case directory([File])

    public init(from decoder: Decoder) throws {

        do {
            let file = try File(from: decoder)
            self = .file(file)
        } catch {
            var container = try decoder.unkeyedContainer()
            var files = [File]()
            while !container.isAtEnd {
                files.append(try container.decode(File.self))
            }

            self = .directory(files)
        }
    }
}

extension Content: Hashable {
    public static func ==(lhs: Content, rhs: Content) -> Bool {
        switch (lhs, rhs) {
        case let (.file(file1), .file(file2)):
            return file1 == file2
        case let (.directory(dir1), .directory(dir2)):
            return dir1 == dir2
        default:
            return false
        }
    }

    public var hashValue: Int {
        switch self {
        case .file(let file):
            return "file".hashValue ^ file.hashValue
        case .directory(let files):
            return files.reduce("directory".hashValue) { $0.hashValue ^ $1.hashValue }
        }
    }
}

extension Content.File.ContentType: Equatable {
    public static func ==(lhs: Content.File.ContentType, rhs: Content.File.ContentType) -> Bool {
        switch (lhs, rhs) {
        case let (.file(size, url), .file(size2, url2)):
            return size == size2 && url == url2
        case (.directory, .directory):
            return true
        case let (.submodule(url), .submodule(url2)):
            return url == url2
        case let (.symlink(target, url), .symlink(target2, url2)):
            return target == target2 && url == url2
        default:
            return false
        }
    }
}

extension Content.File: Hashable {
    public static func ==(lhs: Content.File, rhs: Content.File) -> Bool {
        return lhs.name == rhs.name
            && lhs.path == rhs.path
            && lhs.sha == rhs.sha
            && lhs.content == rhs.content
    }

    public var hashValue: Int {
        return name.hashValue
    }
}


