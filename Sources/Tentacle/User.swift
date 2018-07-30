//
//  User.swift
//  Tentacle
//
//  Created by Matt Diephouse on 4/12/16.
//  Copyright © 2016 Matt Diephouse. All rights reserved.
//

import Foundation

extension User {
    /// A request for issues assigned to the authenticated user.
    ///
    /// https://developer.github.com/v3/issues/#list-issues
    static public var assignedIssues: Request<[Issue]> {
        return Request(method: .get, path: "/issues")
    }
    
    /// A request for the authenticated user's profile.
    ///
    /// https://developer.github.com/v3/users/#get-the-authenticated-user
    static public var profile: Request<UserProfile> {
        return Request(method: .get, path: "/user")
    }
    
    /// A request for the authenticated user's public repositories.
    ///
    /// https://developer.github.com/v3/repos/#list-all-public-repositories
    static public var publicRepositories: Request<[RepositoryInfo]> {
        return Request(method: .get, path: "/repositories")
    }
    
    /// A request for the authenticated user's repositories.
    ///
    /// https://developer.github.com/v3/repos/#list-your-repositories
    static public var repositories: Request<[RepositoryInfo]> {
        return Request(method: .get, path: "/user/repos")
    }
}

extension User {
    /// A request for the user's profile.
    ///
    /// https://developer.github.com/v3/users/#get-a-single-user
    public var profile: Request<UserProfile> {
        return Request(method: .get, path: "/users/\(login)")
    }
    
    /// A request for the user's repositories.
    ///
    /// https://developer.github.com/v3/repos/#list-user-repositories
    public var repositories: Request<[RepositoryInfo]> {
        return Request(method: .get, path: "/users/\(login)/repos")
    }
}

/// A user on GitHub or GitHub Enterprise.
public struct User: CustomStringConvertible, Decodable {
    /// The user's login/username.
    public let login: String
    
    public init(_ login: String) {
        self.login = login
    }
    
    public var description: String {
        return login
    }
}

extension User: Hashable {
    public static func ==(lhs: User, rhs: User) -> Bool {
        return lhs.login == rhs.login
    }
    
    public var hashValue: Int {
        return login.hashValue
    }
}

/// Information about a user on GitHub.
public struct UserInfo: CustomStringConvertible, ResourceType, Identifiable {
    public enum UserType: String, Decodable {
        case user = "User"
        case organization = "Organization"
    }

    /// The unique ID of the user.
    public let id: ID<UserInfo>
    
    /// The user this information is about.
    public let user: User
    
    /// The URL of the user's GitHub page.
    public let url: URL
    
    /// The URL of the user's avatar.
    public let avatarURL: URL

    /// The type of user if it's a regular one or an organization
    public let type: UserType

    public var description: String {
        return user.description
    }

    private enum CodingKeys: String, CodingKey {
        case id
        case user = "login"
        case url = "html_url"
        case avatarURL = "avatar_url"
        case type
    }

    public init(id: ID<UserInfo>, user: User, url: URL, avatarURL: URL, type: UserType) {
        self.id = id
        self.user = user
        self.url = url
        self.avatarURL = avatarURL
        self.type = type
    }

    public init(from decoder: Decoder) throws {
        let container = try decoder.container(keyedBy: CodingKeys.self)
        self.id = try container.decode(ID.self, forKey: .id)
        self.user = try User(from: decoder)
        self.url = try container.decode(URL.self, forKey: .url)
        self.avatarURL = try container.decode(URL.self, forKey: .avatarURL)
        self.type = try container.decode(UserType.self, forKey: .type)
    }
}

extension UserInfo: Equatable {
    public static func ==(lhs: UserInfo, rhs: UserInfo) -> Bool {
        return lhs.id == rhs.id
            && lhs.user == rhs.user
            && lhs.url == rhs.url
            && lhs.avatarURL == rhs.avatarURL
    }
}

/// Extended information about a user on GitHub.
public struct UserProfile: ResourceType {
    /// The user that this information refers to.
    public let user: UserInfo
    
    /// The date that the user joined GitHub.
    public let joinedDate: Date
    
    /// The user's name if they've set one.
    public let name: String?
    
    /// The user's public email address if they've set one.
    public let email: String?
    
    /// The URL of the user's website if they've set one
    /// (the type here is a String because Github lets you use
    /// anything and doesn't validate that you've entered a valid URL)
    public let websiteURL: String?
    
    /// The user's company if they've set one.
    public let company: String?
    
    public var description: String {
        return user.description
    }
    
    public init(user: UserInfo, joinedDate: Date, name: String?, email: String?, websiteURL: String?, company: String?) {
        self.user = user
        self.joinedDate = joinedDate
        self.name = name
        self.email = email
        self.websiteURL = websiteURL
        self.company = company
    }

    public init(from decoder: Decoder) throws {
        self.user = try UserInfo(from: decoder)

        let container = try decoder.container(keyedBy: CodingKeys.self)
        self.joinedDate = try container.decode(Date.self, forKey: .joinedDate)
        self.name = try container.decodeIfPresent(String.self, forKey: .name)
        self.email = try container.decodeIfPresent(String.self, forKey: .email)
        self.websiteURL = try container.decodeIfPresent(String.self, forKey: .websiteURL)
        self.company = try container.decodeIfPresent(String.self, forKey: .company)
    }

    private enum CodingKeys: String, CodingKey {
        case user
        case joinedDate = "created_at"
        case name
        case email
        case websiteURL = "blog"
        case company
    }
}

extension UserProfile: Hashable {
    public static func ==(lhs: UserProfile, rhs: UserProfile) -> Bool {
        return lhs.user == rhs.user
            && lhs.joinedDate == rhs.joinedDate
            && lhs.name == rhs.name
            && lhs.email == rhs.email
            && lhs.websiteURL == rhs.websiteURL
            && lhs.company == rhs.company
    }

    public var hashValue: Int {
        return user.hashValue
    }
}

