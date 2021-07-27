//
//  ArticlesAPI.swift
//  RedditDemo
//
//  Created by Santos Ramon on 7/27/21.
//

import Foundation

// TODO
// The purpose of this APIProtocol is to be replaced/injected on the Unit Tests
// protocol APIProtocol {
//    func fetchAll(completion: @escaping ([Any]?, Error?) -> Void)
// }

class ArticlesAPI {
    
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
