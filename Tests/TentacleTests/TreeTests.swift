//
//  TreeTests.swift
//  Tentacle
//
//  Created by David Caunt on 21/04/2017.
//  Copyright © 2017 Matt Diephouse. All rights reserved.
//

import XCTest
@testable import Tentacle

class TreeTests: XCTestCase {

    func testDecodingTrees() {
        let expected = Tree(
            sha: SHA(hash: "15fb9dd92c823b98b584db9599f629f6c816e619"),
            url: URL(string: "https://api.github.com/repos/Carthage/ReactiveTask/git/trees/15fb9dd92c823b98b584db9599f629f6c816e619")!,
            entries: [
                Tree.Entry(
                    sha: SHA(hash: "010d3ce1339fc9999366291bce76748f6a6caf34"),
                    path: "project.pbxproj",
                    url: URL(string: "https://api.github.com/repos/Carthage/ReactiveTask/git/blobs/010d3ce1339fc9999366291bce76748f6a6caf34")!,
                    type: .blob,
                    mode: .file
                ),
                Tree.Entry(
                    sha: SHA(hash: "e2f7a92fe267aac90ed33349d7e49ce338c5657f"),
                    path: "project.xcworkspace",
                    url: URL(string: "https://api.github.com/repos/Carthage/ReactiveTask/git/trees/e2f7a92fe267aac90ed33349d7e49ce338c5657f")!,
                    type: .tree,
                    mode: .subdirectory
                ),
                Tree.Entry(
                    sha: SHA(hash: "57f355330ec11913b305b53925e442412dea543a"),
                    path: "xcshareddata",
                    url: URL(string: "https://api.github.com/repos/Carthage/ReactiveTask/git/trees/57f355330ec11913b305b53925e442412dea543a")!,
                    type: .tree,
                    mode: .subdirectory
                )
            ],
            isTruncated: false
        )

        XCTAssertEqual(Fixture.TreeForRepository.TreeInReactiveTask.decode()!, expected)
    }
}
