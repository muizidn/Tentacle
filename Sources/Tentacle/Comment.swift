//
//  Comment.swift
//  Tentacle
//
//  Created by Romain Pouclet on 2016-07-27.
//  Copyright © 2016 Matt Diephouse. All rights reserved.
//

import Foundation

extension Repository {
    /// A request for the comments on the given issue.
    ///
    /// https://developer.github.com/v3/issues/comments/#list-comments-on-an-issue
    public func comments(onIssue issue: Int) -> Request<[Comment]> {
        return Request(method: .get, path: "/repos/\(owner)/\(name)/issues/\(issue)/comments")
    }
}

public struct Comment: CustomStringConvertible, ResourceType, Identifiable {

    /// The id of the issue
    public let id: ID<Comment>
    /// The URL to view this comment in a browser
    public let url: URL
    /// The date this comment was created at
    public let createdAt: Date
    /// The date this comment was last updated at
    public let updatedAt: Date
    /// The body of the comment
    public let body: String
    /// The author of this comment
    public let author: UserInfo
    
    public var description: String {
        return body
    }

    private enum CodingKeys: String, CodingKey {
        case id
        case url = "html_url"
        case createdAt = "created_at"
        case updatedAt = "updated_at"
        case body
        case author = "user"


    }
}

extension Comment: Equatable {
    public static func ==(lhs: Comment, rhs: Comment) -> Bool {
        return lhs.id == rhs.id
            && lhs.url == rhs.url
            && lhs.body == rhs.body
    }
}
