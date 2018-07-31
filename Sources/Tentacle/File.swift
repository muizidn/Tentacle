//
//  File.swift
//  Tentacle
//
//  Created by Romain Pouclet on 2016-12-21.
//  Copyright © 2016 Matt Diephouse. All rights reserved.
//

import Foundation

extension Repository {
    /// A request to create a file at a given path in the repository.
    ///
    /// https://developer.github.com/v3/repos/contents/#create-a-file
    public func create(file: File, atPath path: String, inBranch branch: String? = nil) -> Request<FileResponse> {
        let queryItems: [URLQueryItem]
        if let branch = branch {
            queryItems = [ URLQueryItem(name: "branch", value: branch) ]
        } else {
            queryItems = []
        }
        return Request(
            method: .put,
            path: "/repos/\(owner)/\(name)/contents/\(path)",
            queryItems: queryItems
        )
    }
}

public struct File: ResourceType, Encodable {
    /// Commit message
    public let message: String
    /// The committer of the commit
    public let committer: Author?
    /// The author of the commit
    public let author: Author?
    /// Content of the file to create
    public let content: Data
    /// Branch in which the file will be created
    public let branch: String?

    public init(message: String, committer: Author?, author: Author?, content: Data, branch: String?) {
        self.message = message
        self.committer = committer
        self.author = author
        self.content = content
        self.branch = branch
    }

    public func encode(to encoder: Encoder) throws {
        var container = encoder.container(keyedBy: CodingKeys.self)
        try container.encode(message, forKey: .message)
        try container.encode(committer, forKey: .committer)
        try container.encode(author, forKey: .author)
        try container.encode(content.base64EncodedString(), forKey: .content)
        try container.encode(branch, forKey: .branch)
    }

    // Hashable
    public var hashValue: Int {
        return message.hashValue
    }
}
