//
//  EndpointTests.swift
//  Tentacle
//
//  Created by Romain Pouclet on 2017-02-05.
//  Copyright © 2017 Matt Diephouse. All rights reserved.
//

import XCTest
@testable import Tentacle

class EndpointTests: XCTestCase {
    
    func testEndpointProvidesQueryItemsWhenNeeded() {
        let repository = Repository(owner: "palleas", name: "romain-pouclet.com")
        
        let endpoint = repository.content(atPath: "config.yml", atRef: "sample-branch")
        XCTAssertEqual([URLQueryItem(name: "ref", value: "sample-branch")], endpoint.queryItems)

        let endpointWithoutRef = repository.content(atPath: "config.yml", atRef: nil)
        XCTAssertEqual(0, endpointWithoutRef.queryItems.count)
    }

}
