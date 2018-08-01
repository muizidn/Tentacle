//
//  Author.swift
//  Tentacle
//
//  Created by Romain Pouclet on 2016-12-22.
//  Copyright © 2016 Matt Diephouse. All rights reserved.
//

import Foundation

public struct Author: ResourceType, Encodable {
    /// Name of the Author
    let name: String
    /// Email of the Author
    let email: String

    public init(name: String, email: String) {
        self.name = name
        self.email = email
    }
}
