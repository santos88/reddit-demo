//
//  DetailViewController.swift
//  RedditDemo
//
//  Created by Santos Ramon on 7/27/21.
//

import UIKit

class DetailViewController: UIViewController {

    var article:ArticleModel?
    var downloader = ImageDownloader()
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
        let imagePath = article?.thumbnail ?? ""
        downloader.getImage(from: imagePath) { [weak self] image in
            DispatchQueue.main.async {
                self?.mainImage.image = image
            }
        }
    }
    
    override func viewWillDisappear(_ animated: Bool) {
        super.viewWillDisappear(animated)
        downloader.cancel()
    }
}
