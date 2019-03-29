//
//  RepositoryInfo.swift
//  Tentacle
//
//  Created by Romain Pouclet on 2016-08-02.
//  Copyright © 2016 Matt Diephouse. All rights reserved.
//

import Foundation

public struct RepositoryInfo: CustomStringConvertible, ResourceType, Identifiable {
    /// The id of the repository
    public let id: ID<RepositoryInfo>
    
    /// The basic informations about the owner of the repository, either an User or an Organization
    public let owner: UserInfo

    /// The name of the repository
    public let name: String

    /// The name of the repository prefixed with the name of the owner
    public let nameWithOwner: String

    /// The description of the repository
    public let body: String?

    /// The URL of the repository to load in a browser
    public let url: URL

    /// The URL of the homepage for this repository
    public let homepage: URL?

    /// Contains true if the repository is private
    public let isPrivate: Bool

    /// Contains true if the repository is a fork
    public let isFork: Bool

    /// The number of forks of this repository
    public let forksCount: Int

    /// The number of users who starred this repository
    public let stargazersCount: Int

    /// The number of users watching this repository
    public let watchersCount: Int

    /// The number of open issues in this repository
    public let openIssuesCount: Int

    /// The date the last push happened at
    public let pushedAt: Date

    /// The date the repository was created at
    public let createdAt: Date

    /// The date the repository was last updated
    public let updatedAt: Date

    public var description: String {
        return nameWithOwner
    }

    public init(from decoder: Decoder) throws {
        let container = try decoder.container(keyedBy: CodingKeys.self)

        self.id = try container.decode(ID.self, forKey: .id)
        self.owner = try container.decode(UserInfo.self, forKey: .owner)
        self.name = try container.decode(String.self, forKey: .name)
        self.nameWithOwner = try container.decode(String.self, forKey: .nameWithOwner)
        self.body = try container.decodeIfPresent(String.self, forKey: .body)
        self.url = try container.decode(URL.self, forKey: .url)
        self.homepage = try? container.decode(URL.self, forKey: .homepage)
        self.isPrivate = try container.decode(Bool.self, forKey: .isPrivate)
        self.isFork = try container.decode(Bool.self, forKey: .isFork)
        self.forksCount = try container.decode(Int.self, forKey: .forksCount)
        self.stargazersCount = try container.decode(Int.self, forKey: .stargazersCount)
        self.watchersCount = try container.decode(Int.self, forKey: .watchersCount)
        self.openIssuesCount = try container.decode(Int.self, forKey: .openIssuesCount)
        self.pushedAt = try container.decode(Date.self, forKey: .pushedAt)
        self.createdAt = try container.decode(Date.self, forKey: .createdAt)
        self.updatedAt = try container.decode(Date.self, forKey: .updatedAt)
    }

    public init(id: ID<RepositoryInfo>, owner: UserInfo, name: String, nameWithOwner: String, body: String?, url: URL, homepage: URL?, isPrivate: Bool, isFork: Bool, forksCount: Int, stargazersCount: Int, watchersCount: Int, openIssuesCount: Int, pushedAt: Date, createdAt: Date, updatedAt: Date) {
        self.id = id
        self.owner = owner
        self.name = name
        self.nameWithOwner = nameWithOwner
        self.body = body
        self.url = url
        self.homepage = homepage
        self.isPrivate = isPrivate
        self.isFork = isFork
        self.forksCount = forksCount
        self.stargazersCount = stargazersCount
        self.watchersCount = watchersCount
        self.openIssuesCount = openIssuesCount
        self.pushedAt = pushedAt
        self.createdAt = createdAt
        self.updatedAt = updatedAt
    }

    private enum CodingKeys: String, CodingKey {
        case id
        case owner
        case name
        case nameWithOwner = "full_name"
        case body = "description"
        case url = "html_url"
        case homepage
        case isPrivate = "private"
        case isFork = "fork"
        case forksCount = "forks_count"
        case stargazersCount = "stargazers_count"
        case watchersCount = "watchers_count"
        case openIssuesCount = "open_issues_count"
        case pushedAt = "pushed_at"
        case createdAt = "created_at"
        case updatedAt = "updated_at"
    }
}

extension RepositoryInfo: Hashable {
    public static func ==(lhs: RepositoryInfo, rhs: RepositoryInfo) -> Bool {
        return lhs.id == rhs.id
            && lhs.name == rhs.name
            && lhs.nameWithOwner == rhs.nameWithOwner
    }

    public func hash(into hasher: inout Hasher) {
        id.hash(into: &hasher)
        nameWithOwner.hash(into: &hasher)
    }
}
