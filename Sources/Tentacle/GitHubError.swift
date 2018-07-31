//
//  GitHubError.swift
//  Tentacle
//
//  Created by Matt Diephouse on 3/4/16.
//  Copyright © 2016 Matt Diephouse. All rights reserved.
//

import Foundation

/// An error from the GitHub API.
public struct GitHubError: CustomStringConvertible, Error, ResourceType {
    /// The error message from the API.
    public let message: String
    
    public var description: String {
        return message
    }
    
    public init(message: String) {
        self.message = message
    }
}
