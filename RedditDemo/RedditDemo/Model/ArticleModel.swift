//
//  ArticleModel.swift
//  RedditDemo
//
//  Created by Santos Ramon on 7/27/21.
//

import Foundation

struct ArticleModel: Codable, Equatable {
    var title: String
    var author: String
    var created: Double
    var thumbnail: String
    var num_comments: Int
    var wasRead: Bool?
    
    static func ==(lhs: ArticleModel, rhs: ArticleModel) -> Bool {
        let areEqual = lhs.title == rhs.title && lhs.author == rhs.author && lhs.created == rhs.created
        return areEqual
    }
    
    func createdDate() -> Date {
        return Date(timeIntervalSince1970: created)
    }
}

struct ArticlesServerResponse: Codable {
    struct ArticlesData: Codable {
        struct Children: Codable {
            var kind:String
            var data:ArticleModel
        }
        var children : [Children]
    }
    var data:ArticlesData
    var kind:String
    
    func articlesArray() -> [ArticleModel] {
        return data.children.map{ $0.data }
    }
    
}
