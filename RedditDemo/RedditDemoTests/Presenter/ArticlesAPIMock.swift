//
//  File.swift
//  RedditDemoTests
//
//  Created by Santos Ramon on 7/27/21.
//

@testable import RedditDemo
import XCTest

class ArticlesAPIMock: ArticlesAPIProtocol {
    func loadArticles(page: Int, completion: @escaping ([ArticleModel]?, Error?) -> Void) {
        let data = try! JSONHelper().getData(fromJSON: "reddit")
        let serverResponse = try! JSONDecoder().decode(ArticlesServerResponse.self, from: data)
        completion(serverResponse.articlesArray(), nil)
    }
}
