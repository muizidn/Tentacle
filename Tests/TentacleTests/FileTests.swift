//
//  FileTests.swift
//  Tentacle
//
//  Created by Romain Pouclet on 2017-01-25.
//  Copyright © 2017 Matt Diephouse. All rights reserved.
//

@testable import Tentacle
import XCTest

class FileTests: XCTestCase {
    
    func testFileEncoding() throws {
        let palleas = Author(name: "Romain Pouclet", email: "romain.pouclet@gmail.com")

        let file = File(
            message: "Added file",
            committer: palleas,
            author: palleas,
            content: "This is the content of my file".data(using: .utf8)!,
            branch: "master"
        )

        let expectedFile = File(
            message: "Added file",
            committer: palleas,
            author: palleas,
            content: "This is the content of my file".data(using: .utf8)!,
            branch: "master"
        )

        let encoder = JSONEncoder()
        let encodedFileContent = try encoder.encode(file)

        let decoder = JSONDecoder()
        let decodedFile = try decoder.decode(File.self, from: encodedFileContent)

        XCTAssertEqual(expectedFile, decodedFile)
    }

    func testFileEncodingWithoutOptionalArgs() throws {
        let file = File(
            message: "Added file",
            committer: nil,
            author: nil,
            content: "This is the content of my file".data(using: .utf8)!,
            branch: nil
        )

        let expectedFile = File(
            message: "Added file",
            committer: nil,
            author: nil,
            content: "This is the content of my file".data(using: .utf8)!,
            branch: nil
        )

        let encoder = JSONEncoder()
        let encodedFileContent = try encoder.encode(file)

        let decoder = JSONDecoder()
        let decodedFile = try decoder.decode(File.self, from: encodedFileContent)

        XCTAssertEqual(expectedFile, decodedFile)
    }
}
