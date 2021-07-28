//
//  ArticlesPresenterTests.swift
//  RedditDemoTests
//
//  Created by Santos Ramon on 7/27/21.
//

import XCTest
@testable import RedditDemo

class ArticlesPresenterTests: XCTestCase {
    var sut: ArticlesPresenter!
    
    override func setUpWithError() throws {
        super.setUp()
        sut = ArticlesPresenter(api: ArticlesAPIMock())
    }
    
    func testLoadCache() {
        sut.loadArticles { _, _ in }
        XCTAssertEqual(sut.cache.count, 25)
    }
    
    func testArticleWasRead() {
        sut.loadArticles { _, _ in }
        sut.articleWasReadAtIndex(row: 0)
        XCTAssertTrue(sut.cache[0].wasRead!)
    }
    
    func testRemoveArticle() {
        sut.loadArticles { _, _ in }
        XCTAssertEqual(sut.cache.count, 25)
        sut.remove(article: sut.cache.first!)
        XCTAssertEqual(sut.cache.count, 24)
        sut.remove(article: sut.cache.last!)
        XCTAssertEqual(sut.cache.count, 23)
    }
    
    func testRemoveAll() {
        sut.loadArticles { _, _ in }
        XCTAssertEqual(sut.cache.count, 25)
        sut.removeAllArticles()
        XCTAssertEqual(sut.cache.count, 0)
    }
    
}
