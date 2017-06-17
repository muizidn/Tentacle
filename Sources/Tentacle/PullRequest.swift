//
//  PullRequest.swift
//  Tentacle
//
//  Created by Romain Pouclet on 2016-05-23.
//  Copyright © 2016 Matt Diephouse. All rights reserved.
//

import Foundation

public struct PullRequest: CustomStringConvertible, ResourceType {
    /// The URL to view the Pull Request is an browser
    public let url: URL

    /// The URL to the diff showing all the changes included in this pull request
    public let diffURL: URL

    /// The URL to a downloadable patch for this pull request
    public let patchURL: URL

    public var description: String {
        return url.absoluteString
    }

    private enum CodingKeys: String, CodingKey {
        case url = "html_url"
        case diffURL = "diff_url"
        case patchURL = "patch_url"
    }
}

extension PullRequest: Hashable {
    public static func ==(lhs: PullRequest, rhs: PullRequest) -> Bool {
        return lhs.url == rhs.url
    }

    public var hashValue: Int {
        return url.hashValue
    }
}
