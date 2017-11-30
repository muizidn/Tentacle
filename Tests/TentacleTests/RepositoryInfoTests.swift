//
//  RepositoryInfoTests.swift
//  Tentacle
//
//  Created by Romain Pouclet on 2016-08-02.
//  Copyright © 2016 Matt Diephouse. All rights reserved.
//

import XCTest
@testable import Tentacle

class RepositoryInfoTests: XCTestCase {

    func testUserRepositoryInfoAreEquals() {
        let palleasOpensource = UserInfo(
            id: 15802020,
            user: User("Palleas-opensource"),
            url: URL(string: "https://github.com/Palleas-opensource")!,
            avatarURL: URL(string: "https://avatars.githubusercontent.com/u/15802020?v=3")!,
            type: .user
        )

        let expected = [
            RepositoryInfo(
                id: 59615946,
                owner: palleasOpensource,
                name: "Sample-repository",
                nameWithOwner: "Palleas-opensource/Sample-repository",
                body: "",
                url: URL(string: "https://github.com/Palleas-opensource/Sample-repository")!,
                homepage: nil,
                isPrivate: false,
                isFork: false,
                forksCount: 0,
                stargazersCount: 0,
                watchersCount: 0,
                openIssuesCount: 2,
                pushedAt: DateFormatter.iso8601.date(from: "2016-07-14T01:40:08Z")!,
                createdAt: DateFormatter.iso8601.date(from: "2016-05-24T23:38:17Z")!,
                updatedAt: DateFormatter.iso8601.date(from: "2016-05-24T23:38:17Z")!
            )
        ]

        let decoded: [RepositoryInfo] = Fixture.RepositoriesForUser.RepositoriesForPalleasOpensource.decode()!

        XCTAssertEqual(decoded, expected)
    }

    func testOrganizationRepositoryAreEqual() {
        let raccommunity = UserInfo(
            id: 18710012,
            user: User("RACCommunity"),
            url: URL(string: "https://github.com/RACCommunity")!,
            avatarURL: URL(string: "https://avatars.githubusercontent.com/u/18710012?v=3")!,
            type: .organization
        )

        let expected = [
            RepositoryInfo(
                id: 35350514,
                owner: raccommunity,
                name: "Rex",
                nameWithOwner: "RACCommunity/Rex",
                body: "ReactiveCocoa Extensions",
                url: URL(string: "https://github.com/RACCommunity")!,
                homepage: nil,
                isPrivate: false,
                isFork: false,
                forksCount: 33,
                stargazersCount: 193,
                watchersCount: 193,
                openIssuesCount: 16,
                pushedAt: DateFormatter.iso8601.date(from: "2016-08-01T08:15:31Z")!,
                createdAt: DateFormatter.iso8601.date(from: "2015-05-10T00:15:08Z")!,
                updatedAt: DateFormatter.iso8601.date(from: "2016-07-31T12:12:36Z")!
            ),
            RepositoryInfo(
                id: 49464897,
                owner: raccommunity,
                name: "RACNest",
                nameWithOwner: "RACCommunity/RACNest",
                body: "RAC + MVVM examples :mouse::mouse::mouse:",
                url: URL(string: "https://github.com/RACCommunity/RACNest")!,
                homepage: nil,
                isPrivate: false,
                isFork: false,
                forksCount: 6,
                stargazersCount: 82,
                watchersCount: 82,
                openIssuesCount: 3,
                pushedAt: DateFormatter.iso8601.date(from: "2016-04-27T07:22:45Z")!,
                createdAt: DateFormatter.iso8601.date(from: "2016-01-12T01:00:02Z")!,
                updatedAt: DateFormatter.iso8601.date(from: "2016-08-02T16:07:39Z")!
            ),
            RepositoryInfo(
                id: 57858100,
                owner: raccommunity,
                name: "contributors",
                nameWithOwner: "RACCommunity/contributors",
                body: "ReactiveCocoa's Community Guidelines",
                url: URL(string: "https://github.com/RACCommunity")!,
                homepage: nil,
                isPrivate: false,
                isFork: false,
                forksCount: 1,
                stargazersCount: 16,
                watchersCount: 16,
                openIssuesCount: 4,
                pushedAt: DateFormatter.iso8601.date(from: "2016-05-02T10:35:31Z")!,
                createdAt: DateFormatter.iso8601.date(from: "2016-05-02T00:27:44Z")!,
                updatedAt: DateFormatter.iso8601.date(from: "2016-07-27T11:39:23Z")!
            ),
            RepositoryInfo(
                id: 59124784,
                owner: raccommunity,
                name: "racurated",
                nameWithOwner: "RACCommunity/racurated",
                body: "Curated list of ReactiveCocoa projects.",
                url: URL(string:     "https://github.com/RACCommunity/racurated")!,
                homepage: URL(string: "https://raccommunity.github.io/racurated/"),
                isPrivate: false,
                isFork: false,
                forksCount: 0,
                stargazersCount: 5,
                watchersCount: 5,
                openIssuesCount: 0,
                pushedAt: DateFormatter.iso8601.date(from: "2016-06-07T23:47:44Z")!,
                createdAt: DateFormatter.iso8601.date(from: "2016-05-18T14:47:59Z")!,
                updatedAt: DateFormatter.iso8601.date(from: "2016-07-27T11:39:11Z")!
            ),
            RepositoryInfo(
                id: 75979247,
                owner: raccommunity,
                name: "ReactiveCollections",
                nameWithOwner: "RACCommunity/ReactiveCollections",
                body: "Reactive collections for Swift using ReactiveSwift 🚗 🚕 🚙 ",
                url: URL(string: "https://github.com/RACCommunity/ReactiveCollections")!,
                homepage: nil,
                isPrivate: false,
                isFork: false,
                forksCount: 0,
                stargazersCount: 6,
                watchersCount: 6,
                openIssuesCount: 7,
                pushedAt: DateFormatter.iso8601.date(from: "2016-12-21T19:32:19Z")!,
                createdAt: DateFormatter.iso8601.date(from: "2016-12-08T22:08:36Z")!,
                updatedAt: DateFormatter.iso8601.date(from: "2016-12-21T17:53:43Z")!),
            RepositoryInfo(
                id: 88407587,
                owner: raccommunity,
                name: "jazzy",
                nameWithOwner: "RACCommunity/jazzy",
                body: "Soulful docs for Swift & Objective-C",
                url: URL(string: "https://github.com/RACCommunity/jazzy")!,
                homepage: URL(string: "https://realm.io"),
                isPrivate: false,
                isFork: true,
                forksCount: 0,
                stargazersCount: 0,
                watchersCount: 0,
                openIssuesCount: 1,
                pushedAt: DateFormatter.iso8601.date(from: "2017-04-16T14:44:51Z")!,
                createdAt: DateFormatter.iso8601.date(from: "2017-04-16T11:00:24Z")!,
                updatedAt: DateFormatter.iso8601.date(from: "2017-04-16T11:00:26Z")!)
        ]

        let decoded: [RepositoryInfo] = Fixture.RepositoriesForOrganization.RepositoriesForRACCommunity.decode()!

        XCTAssertEqual(decoded, expected)
    }

    func testDecodedRepositoryInfo() {
        let mdiep = UserInfo(
            id: 18710012,
            user: User("mdiep"),
            url: URL(string: "https://github.com/mdiep")!,
            avatarURL: URL(string: "https://avatars2.githubusercontent.com/u/1302?v=4")!,
            type: .user
        )

        let expected = RepositoryInfo(
            id: 53076616,
            owner: mdiep,
            name: "Tentacle",
            nameWithOwner: "mdiep/Tentacle",
            body: "A Swift framework for the GitHub API",
            url: URL(string: "https://github.com/mdiep/Tentacle")!,
            homepage: nil,
            isPrivate: false,
            isFork: false,
            forksCount: 16,
            stargazersCount: 189,
            watchersCount: 189,
            openIssuesCount: 1,
            pushedAt: DateFormatter.iso8601.date(from: "2017-11-25T06:36:01Z")!,
            createdAt: DateFormatter.iso8601.date(from: "2016-03-03T19:20:49Z")!,
            updatedAt: DateFormatter.iso8601.date(from: "2017-11-26T16:01:50Z")!
        )

        let decoded: RepositoryInfo = Fixture.Repositories.Tentacle.decode()!

        XCTAssertEqual(decoded, expected)
    }
}
