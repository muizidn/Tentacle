//
//  TreeTests.swift
//  Tentacle
//
//  Created by David Caunt on 21/04/2017.
//  Copyright © 2017 Matt Diephouse. All rights reserved.
//

import Foundation
import XCTest
@testable import Tentacle

class TreeTests: XCTestCase {

    let entries = [
        Tree.Entry(
            type: .tree(
                url: URL(string: "https://api.github.com/repos/Palleas-opensource/Sample-repository/git/trees/5bfad2b3f8e483b6b173d8aaff19597e84626f15")!
            ),
            sha: SHA(hash: "5bfad2b3f8e483b6b173d8aaff19597e84626f15"),
            path: "Directory",
            mode: .subdirectory
        ),
        Tree.Entry(
            type: .blob(
                url: URL(string: "https://api.github.com/repos/Palleas-opensource/Sample-repository/git/blobs/c3eb8708a0a5aaa4f685aab24ef6403fbfd28efc")!,
                size: 18
            ),
            sha: SHA(hash: "c3eb8708a0a5aaa4f685aab24ef6403fbfd28efc"),
            path: "README.markdown",
            mode: .file
        ),
        Tree.Entry(
            type: .commit,
            sha: SHA(hash: "7a84505a3c553fd8e2879cfa63753b0cd212feb8"),
            path: "Tentacle",
            mode: .submodule
        ),
        Tree.Entry(
            type: .blob(
                url: URL(string: "https://api.github.com/repos/Palleas-opensource/Sample-repository/git/blobs/1e3f1fd0bc1f65cf4701c217f4d1fd9a3cd50721")!,
                size: 12
            ),
            sha: SHA(hash: "1e3f1fd0bc1f65cf4701c217f4d1fd9a3cd50721"),
            path: "say",
            mode: .file
        )
    ]

    func testDecodingTrees() {
        let expected = Tree(
            sha: SHA(hash: "0c0dfafa361836e11aedcbb95c1f05d3f654aef0"),
            url: URL(string: "https://api.github.com/repos/Palleas-opensource/Sample-repository/git/trees/0c0dfafa361836e11aedcbb95c1f05d3f654aef0")!,
            entries: entries,
            isTruncated: false
        )

        XCTAssertEqual(Fixture.TreeForRepository.TreeInSampleRepository.decode()!, expected)
    }

    func testTreeEncoding() {
        let newTree = NewTree(entries: entries, base: "5bfad2b3f8e483b6b173d8aaff19597e84626f15")

        let expected: JSON = .object([
            "base_tree": .string("5bfad2b3f8e483b6b173d8aaff19597e84626f15"),
            "tree": .array([
                .object([
                    "path": .string("Directory"),
                    "mode": .string("040000"),
                    "type": .string("tree"),
                    "sha": .string("5bfad2b3f8e483b6b173d8aaff19597e84626f15")
                ]),
                .object([
                    "path": .string("README.markdown"),
                    "mode": .string("100644"),
                    "type": .string("blob"),
                    "sha": .string("c3eb8708a0a5aaa4f685aab24ef6403fbfd28efc")
                ]),
                .object([
                    "path": .string("Tentacle"),
                    "mode": .string("160000"),
                    "type": .string("commit"),
                    "sha": .string("7a84505a3c553fd8e2879cfa63753b0cd212feb8")
                ]),
                .object([
                    "path": .string("say"),
                    "mode": .string("100644"),
                    "type": .string("blob"),
                    "sha": .string("1e3f1fd0bc1f65cf4701c217f4d1fd9a3cd50721")
                ])
            ]),
        ])

        XCTAssertEqual(newTree.encode(), expected)
    }

    func testTreeEncodingWithoutBase() {
        let newTree = NewTree(entries: [], base: nil)

        let expected: JSON = .object([
            "tree": .array([]),
        ])

        XCTAssertEqual(newTree.encode(), expected)
    }
}
