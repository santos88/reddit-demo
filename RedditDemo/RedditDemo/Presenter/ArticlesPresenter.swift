//
//  ArticlesPresenter.swift
//  RedditDemo
//
//  Created by Santos Ramon on 7/27/21.
//

import Foundation

class ArticlesPresenter {

    var cache = [ArticleModel]()

    func loadArticles(completion: @escaping ([ArticleModel]?, Error?) -> Void) {
        ArticlesAPI().loadArticles(page: 1) { [weak self] (articles, error) in
            if let records = articles {
                self?.cache = records
            }
            completion(self?.cache, error)
        }
    }
    
    func articleWasReadAtIndex(row:Int) {
        cache[row].wasRead = true;
    }
    
    func remove(article:ArticleModel) {
        cache = cache.filter { $0 != article }
    }
    
    func removeAllArticles() {
        cache.removeAll()
    }
}
