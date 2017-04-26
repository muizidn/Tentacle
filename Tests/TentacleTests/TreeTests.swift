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

    func testDecodingTrees() {
        let expected = Tree(
            sha: SHA(hash: "0c0dfafa361836e11aedcbb95c1f05d3f654aef0"),
            url: URL(string: "https://api.github.com/repos/Palleas-opensource/Sample-repository/git/trees/0c0dfafa361836e11aedcbb95c1f05d3f654aef0")!,
            entries: [
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

            ],
            isTruncated: false
        )

        XCTAssertEqual(Fixture.TreeForRepository.TreeInSampleRepository.decode()!, expected)
    }
}
