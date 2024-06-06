//
//  NewsTableViewCell.swift
//  NewsApp-Task
//
//  Created by Emincan Antalyalı on 10.07.2023.
//

import UIKit

class NewsTableViewCell: UITableViewCell {

    @IBOutlet weak var newsDetail: UILabel!
    @IBOutlet weak var newsTitle: UILabel!
    @IBOutlet weak var newsPhoto: UIImageView!
    
    var article: Article? {
        didSet{
            newsPhoto.setImage(article?.urlToImage)
            newsTitle.text = article?.title
            newsDetail.text = article?.author
        }
    }
    
    
    override func awakeFromNib() {
        super.awakeFromNib()
        article = nil
    }

    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)
    }
    
}
