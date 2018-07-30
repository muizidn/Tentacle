//
//  Issue.swift
//  Tentacle
//
//  Created by Romain Pouclet on 2016-05-23.
//  Copyright © 2016 Matt Diephouse. All rights reserved.
//

import Foundation

extension Repository {
    /// A request for issues in the repository.
    ///
    /// https://developer.github.com/v3/issues/#list-issues-for-a-repository
    public var issues: Request<[Issue]> {
        return Request(method: .get, path: "/repos/\(owner)/\(name)/issues")
    }

    /// A request for an issue in the repository
    ///
    /// https://developer.github.com/v3/issues/#get-a-single-issue
    public func issue(id: ID<Issue>) -> Request<Issue> {
        return Request(method: .get, path: "/repos/\(owner)/\(name)/issues/\(id.string)")
    }
}

/// An Issue on Github
public struct Issue: CustomStringConvertible, ResourceType, Identifiable {
    public enum State: String, ResourceType {
        case open = "open"
        case closed = "closed"
    }

    /// The id of the issue
    public let id: ID<Issue>

    /// The URL to view this issue in a browser
    public let url: URL?

    /// The number of the issue in the repository it belongs to
    public let number: Int

    /// The state of the issue, open or closed
    public let state: State

    /// The title of the issue
    public let title: String

    /// The body of the issue
    public let body: String

    /// The author of the issue
    public let user: UserInfo?

    /// The labels associated to this issue, if any
    public let labels: [Label]

    /// The user assigned to this issue, if any
    public let assignees: [UserInfo]

    /// The milestone this issue belongs to, if any
    public let milestone: Milestone?

    /// True if the issue has been closed by a contributor
    public let isLocked: Bool

    /// The number of comments
    public let commentCount: Int

    /// Contains the informations like the diff URL when the issue is a pull-request
    public let pullRequest: PullRequest?

    /// The date this issue was closed at, if it ever were
    public let closedAt: Date?

    /// The date this issue was created at
    public let createdAt: Date

    /// The date this issue was updated at
    public let updatedAt: Date

    public var description: String {
        return title
    }

    public init(id: ID<Issue>, url: URL?, number: Int, state: State, title: String, body: String, user: UserInfo, labels: [Label], assignees: [UserInfo], milestone: Milestone?, isLocked: Bool, commentCount: Int, pullRequest: PullRequest?, closedAt: Date?, createdAt: Date, updatedAt: Date) {
        self.id = id
        self.url = url
        self.number = number
        self.state = state
        self.title = title
        self.body = body
        self.user = user
        self.milestone = milestone
        self.isLocked = isLocked
        self.commentCount = commentCount
        self.pullRequest = pullRequest
        self.labels = labels
        self.assignees = assignees
        self.closedAt = closedAt
        self.createdAt = createdAt
        self.updatedAt = updatedAt
    }

    private enum CodingKeys: String, CodingKey {
        case id
        case url = "html_url"
        case number
        case state
        case title
        case body
        case user
        case labels
        case assignees
        case milestone
        case isLocked = "locked"
        case commentCount = "comments"
        case pullRequest = "pull_request"
        case closedAt = "closed_at"
        case createdAt = "created_at"
        case updatedAt = "updated_at"
    }
}

extension Issue: Equatable {
    public static func ==(lhs: Issue, rhs: Issue) -> Bool {
        return lhs.id == rhs.id
            && lhs.url == rhs.url
            && lhs.number == rhs.number
            && lhs.state == rhs.state
            && lhs.title == rhs.title
            && lhs.body == rhs.body
            && lhs.isLocked == rhs.isLocked
            && lhs.commentCount == rhs.commentCount
            && lhs.createdAt == rhs.createdAt
            && lhs.updatedAt == rhs.updatedAt
            && lhs.labels == rhs.labels
            && lhs.milestone == rhs.milestone
            && lhs.pullRequest == rhs.pullRequest
    }
}
