//
//  ArticleModelTests.swift
//  RedditDemoTests
//
//  Created by Santos Ramon on 7/27/21.
//

import XCTest
@testable import RedditDemo

class ArticleModelTests: XCTestCase {
    var serverResponse: ArticlesServerResponse!
    // Subject Under Test
    var sut: ArticleModel!
    
    override func setUpWithError() throws {
        super.setUp()
        let data = try! JSONHelper().getData(fromJSON: "reddit")
        serverResponse = try! JSONDecoder().decode(ArticlesServerResponse.self, from: data)
        guard let article = serverResponse.articlesArray().first else {
            XCTFail("Error parsing")
            return
        }
        sut = article
    }
    
    func testUsername() {
        XCTAssertEqual(sut.author, "SalazarRED")
        XCTAssertEqual(sut.authorFormatted(), "@SalazarRED")
    }

    func testComments() {
        XCTAssertEqual(sut.num_comments, 2505)
        XCTAssertEqual(sut.commentsFormatted(), "2505 Comments")
    }
}
