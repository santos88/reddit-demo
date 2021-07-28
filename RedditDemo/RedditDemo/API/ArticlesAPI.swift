//
//  ArticlesAPI.swift
//  RedditDemo
//
//  Created by Santos Ramon on 7/27/21.
//

import Foundation

protocol ArticlesAPIProtocol {
    func loadArticles(page:Int, completion: @escaping ([ArticleModel]?, Error?) -> Void)
}

class ArticlesAPI: ArticlesAPIProtocol {
    func loadArticles(page:Int, completion: @escaping ([ArticleModel]?, Error?) -> Void) {
        
        let endpoint: String = "https://www.reddit.com/top/.json?count=20"
        let urlRequest = URLRequest(url: URL(string: endpoint)!)
        
        let config = URLSessionConfiguration.default
        let session = URLSession(configuration: config)
        
        let task = session.dataTask(with: urlRequest) {
            (data, response, error) in
            guard let data = data else { return }
            do {
                let decoder = JSONDecoder()
                let parsedServerResponse = try decoder.decode(ArticlesServerResponse.self, from: data)
                completion(parsedServerResponse.articlesArray(), nil)
            } catch let err {
                completion(nil, err)
            }
        }
        task.resume()
    }
    
}
