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

    var downloader = ImageDownloader()
    
    var articleModel: ArticleModel?
    weak var delegate: ArticleCellProtocol?
    
    override func awakeFromNib() {
        super.awakeFromNib()
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
        downloader.getImage(from: model.thumbnail) { [weak self] image in
            DispatchQueue.main.async {
                self?.thumbnailImage.image = image
            }
        }
    }
    
    override func prepareForReuse() {
        unreadImage.isHidden = false
        thumbnailImage.image = nil;
        usernameLabel.text = ""
        timeLabel.text = ""
        titleLabel.text = ""
        commentsLabel.text = ""
        downloader.cancel()
    }
    
    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)
    }

    @IBAction func tapDismiss(_ sender: Any) {
        delegate?.remove(model: self.articleModel)
    }
}
