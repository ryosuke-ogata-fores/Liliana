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
        dispatch_async(dispatch_get_global_queue(DISPATCH_QUEUE_PRIORITY_DEFAULT, 0), { () -> Void in
            let url:NSURL = NSURL(string: article.imgUrl)!
            var err: NSError?
            
            var request:NSURLRequest = NSURLRequest(URL: url,
                cachePolicy: NSURLRequestCachePolicy.ReloadIgnoringLocalCacheData,
                timeoutInterval: 8.0)
            NSURLConnection.sendAsynchronousRequest(request,
                queue: NSOperationQueue(),
                completionHandler: { (response:NSURLResponse!, data:NSData!, error:NSError!) -> Void in
                    dispatch_async(dispatch_get_main_queue(), { () -> Void in
                        if (data == nil || error != nil) {
                            println(error.code, error.description);
                            self.headImageView.image = UIImage(named: "not")
                        }
                        else {
                            self.headImageView.image = UIImage(data: data)
                        }
                        self.layoutIfNeeded()
                    });
            });
        });
        self.titleLabel.text = article.title
        self.contentLabel.text = article.content
        var fmt:NSDateFormatter = NSDateFormatter()
        fmt.locale = NSLocale(localeIdentifier: "ja_JP");
        fmt.dateFormat = "yyyy/MM/dd"
        self.publishDateLabel.text = fmt.stringFromDate(article.publishDate)
    }
}