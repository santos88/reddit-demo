//
//  DetailViewController.swift
//  RedditDemo
//
//  Created by Santos Ramon on 7/27/21.
//

import UIKit

class DetailViewController: UIViewController {

    var article:ArticleModel?
    var imageFromUrlTask: URLSessionDataTask?
    @IBOutlet weak var mainImage: UIImageView!
    @IBOutlet weak var usernameLabel: UILabel!
    @IBOutlet weak var timeLabel: UILabel!
    @IBOutlet weak var titleLabel: UILabel!
    @IBOutlet weak var commentsLabel: UILabel!

    override func viewDidLoad() {
        super.viewDidLoad()
        configureView()
    }
    
    func configureView() {
        self.usernameLabel.text = article?.authorFormatted()
        self.titleLabel.text = article?.title
        self.timeLabel.text = article?.createdDate().timeAgo()
        self.commentsLabel.text = article?.commentsFormatted()
        loadImage()
    }
    
    override func viewWillDisappear(_ animated: Bool) {
        super.viewWillDisappear(animated)
        imageFromUrlTask?.cancel()
    }
    
    // TODO: THIS METHOD SHOULD BE MOVED INTO OTHER CLASS
    func loadImage() {
        guard let stringURL = article?.thumbnail, let imageURL = URL(string:stringURL) else {
            return;
        }
        
        let session = URLSession(configuration: .default)
        imageFromUrlTask = session.dataTask(with: imageURL) {[weak self] (data, response, error) in
            if let e = error {
                print("Error Occurred: \(e)")
                
            } else {
                if (response as? HTTPURLResponse) != nil {
                    if let imageData = data {
                        let image = UIImage(data: imageData)
                        DispatchQueue.main.async {
                            self?.mainImage.image = image
                        }
                    } else {
                        print("Image file is currupted")
                    }
                } else {
                    print("No response from server")
                }
            }
        }
        imageFromUrlTask?.resume()
    }

}
