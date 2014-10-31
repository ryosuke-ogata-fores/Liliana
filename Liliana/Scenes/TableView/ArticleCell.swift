//
//  ArticleCell.swift
//  Liliana
//
//  Created by rogata on 10/29/14.
//  Copyright (c) 2014 rogata. All rights reserved.
//

import UIKit

class ArticleCell: UITableViewCell {
    
    @IBOutlet weak var headImageView: UIImageView!
    @IBOutlet weak var titleLabel: UILabel!
    @IBOutlet weak var contentLabel: UILabel!
    @IBOutlet weak var publishDateLabel: UILabel!
    class func cellIdentifier() -> (NSString) {
        return "ArticleCell"
    }

    class func cellHeight() -> (CGFloat) {
        return 86.0
    }
    
    func setArticleModel(article:ArticleModel) {
        self.headImageView.setImageWithUrl(article.imgUrl, defIconName: "not")
        self.titleLabel.text = article.title
        self.contentLabel.text = article.content
        var fmt:NSDateFormatter = NSDateFormatter()
        fmt.locale = NSLocale(localeIdentifier: "ja_JP");
        fmt.dateFormat = "yyyy/MM/dd"
        self.publishDateLabel.text = fmt.stringFromDate(article.publishDate)
    }
}