//
//  Milestone.swift
//  Tentacle
//
//  Created by Romain Pouclet on 2016-05-23.
//  Copyright © 2016 Matt Diephouse. All rights reserved.
//

import Foundation

public struct Milestone: CustomStringConvertible, ResourceType, Identifiable {
    public enum State: String, Decodable {
        case open
        case closed
    }

    /// The ID of the milestone
    public let id: ID<Milestone>

    /// The number of the milestone in the repository it belongs to
    public let number: Int

    /// The state of the Milestone, open or closed
    public let state: State

    /// The title of the milestone
    public let title: String

    /// The description of the milestone
    public let body: String

    /// The user who created the milestone
    public let creator: UserInfo

    /// The number of the open issues in the milestone
    public let openIssueCount: Int

    /// The number of closed issues in the milestone
    public let closedIssueCount: Int

    /// The date the milestone was created
    public let createdAt: Date

    /// The date the milestone was last updated at
    public let updatedAt: Date

    /// The date the milestone was closed at, if ever
    public let closedAt: Date?

    /// The date the milestone is due on
    public let dueOn: Date?

    /// The URL to view this milestone in a browser
    public let url: URL

    public var description: String {
        return title
    }

    private enum CodingKeys: String, CodingKey {
        case id
        case number
        case state
        case title
        case body = "description"
        case creator
        case openIssueCount = "open_issues"
        case closedIssueCount = "closed_issues"
        case createdAt = "created_at"
        case updatedAt = "updated_at"
        case closedAt = "closed_at"
        case dueOn = "due_on"
        case url = "html_url"
    }
}

extension Milestone: Equatable {
    public static func ==(lhs: Milestone, rhs: Milestone) -> Bool {
        return lhs.id == rhs.id
    }
}
