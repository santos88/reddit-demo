//
//  ImageHelper.swift
//  RedditDemo
//
//  Created by Santos Ramon on 7/27/21.
//

import UIKit

class ImageDownloader {
    private var imageFromUrlTask: URLSessionDataTask?
        
    func cancel() {
        imageFromUrlTask?.cancel()
    }
    
    func getImage(from path: String, completion: @escaping (UIImage?) -> ()) {
        guard let imageURL = URL(string: path) else {
            return
        }
        
        let session = URLSession(configuration: .default)
        imageFromUrlTask = session.dataTask(with: imageURL) { (data, response, error) in
            if let e = error {
                print("Error Occurred: \(e)")
                completion(nil)
            } else {
                if (response as? HTTPURLResponse) != nil {
                    if let imageData = data {
                        let image = UIImage(data: imageData)
                            completion(image)
                    } else {
                        // print("Image file is currupted")
                        completion(nil)
                    }
                } else {
                    // print("No response from server")
                    completion(nil)
                }
            }
        }
        imageFromUrlTask?.resume()
    }

}
