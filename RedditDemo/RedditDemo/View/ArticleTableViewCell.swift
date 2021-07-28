//
//  ArticleTableViewCell.swift
//  RedditDemo
//
//  Created by Santos Ramon on 7/27/21.
//

import UIKit

protocol ArticleCellProtocol:class {
    func remove(model:ArticleModel?)
}

class ArticleTableViewCell: UITableViewCell {

    @IBOutlet weak var unreadImage: UIImageView!
    @IBOutlet weak var thumbnailImage: UIImageView!
    @IBOutlet weak var usernameLabel: UILabel!
    @IBOutlet weak var timeLabel: UILabel!
    @IBOutlet weak var titleLabel: UILabel!
    @IBOutlet weak var commentsLabel: UILabel!

    var imageFromUrlTask: URLSessionDataTask?
    
    var articleModel: ArticleModel?
    weak var delegate: ArticleCellProtocol?
    
    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
    }

    func configure(model: ArticleModel) {
        articleModel = model
        usernameLabel.text = model.authorFormatted()
        timeLabel.text = model.createdDate().timeAgo()
        titleLabel.text = model.title
        commentsLabel.text = model.commentsFormatted()
        if let wasRead = model.wasRead {
            unreadImage.isHidden = wasRead
        }
        loadImage()
    }
    
    override func prepareForReuse() {
        unreadImage.isHidden = false
        thumbnailImage.image = nil;
        usernameLabel.text = ""
        timeLabel.text = ""
        titleLabel.text = ""
        commentsLabel.text = ""
        imageFromUrlTask?.cancel()
    }
    
    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)
    }

    @IBAction func tapDismiss(_ sender: Any) {
        delegate?.remove(model: self.articleModel)
    }
    
    // TODO: THIS METHOD SHOULD BE MOVED INTO OTHER CLASS
    func loadImage() {
        guard let stringURL = articleModel?.thumbnail, let imageURL = URL(string:stringURL) else {
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
                            self?.thumbnailImage.image = image
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
