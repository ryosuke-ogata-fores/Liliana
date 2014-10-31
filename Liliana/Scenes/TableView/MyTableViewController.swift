//
//  MyTableViewController.swift
//  Liliana
//
//  Created by rogata on 10/29/14.
//  Copyright (c) 2014 rogata. All rights reserved.
//

import UIKit

class MyTableViewController: UIViewController, UITableViewDelegate, UITableViewDataSource {

    @IBOutlet weak var tableView: UITableView!
    
    var articles:[ArticleModel] = []
    
    override func viewDidLoad() {
        super.viewDidLoad()
        self.tableView.registerNib(UINib(nibName: "ArticleCell", bundle: nil), forCellReuseIdentifier: ArticleCell.cellIdentifier())
    }
    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
    }
    override func viewDidAppear(animated: Bool) {
        super.viewDidAppear(animated)
        // 初期データ投入（仮）
        var articles:[ArticleModel] = [];
        for i in 0...20 {
            let num = i + 1
            let additionDay:Double = 1000 * 60 * 60 * 24
//            additionDay *= num
            var d:NSDate = NSDate(timeIntervalSince1970: NSDate().timeIntervalSince1970 as Double + additionDay)
            var dict:[String:AnyObject] = [
                "id": 1,
                "title": "Swift(* '-')ノ",
                "imgUrl": (i % 2 == 0) ? "http://cdn3.iconfinder.com/data/icons/free-social-icons/67/github_circle_color-256.png": "http://cdn3.iconfinder.com/data/icons/free-social-icons/67/linkedin_square_color-128.png",
                "content": "Swift is an innovative new programming language for Cocoa and Cocoa Touch.",
                "linkUrl": "https://developer.apple.com/swift/",
                "publishDate": "2014/01/02 10:11:12"
            ]
            var model:ArticleModel = ArticleModel(dict:dict)
            articles.append(model)
        }
        self.articles = articles
        self.tableView.reloadData()
    }
    
    func tableView(tableView: UITableView, heightForRowAtIndexPath indexPath: NSIndexPath) -> CGFloat {
        return ArticleCell.cellHeight()
    }
    
    func tableView(tableView: UITableView, heightForHeaderInSection section: Int) -> CGFloat {
        return 0.00000001
    }

    func tableView(tableView: UITableView, heightForFooterInSection section: Int) -> CGFloat {
        return 0.00000001
    }

    func tableView(tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return self.articles.count
    }

    func tableView(tableView: UITableView, cellForRowAtIndexPath indexPath: NSIndexPath) -> UITableViewCell {
        let cell:ArticleCell = tableView.dequeueReusableCellWithIdentifier(ArticleCell.cellIdentifier(), forIndexPath: indexPath) as ArticleCell
        cell.setArticleModel(self.articles[indexPath.row])
        return cell
    }
    
    func numberOfSectionsInTableView(tableView: UITableView) -> Int {
        return 1
    }
    
    func tableView(tableView: UITableView, didSelectRowAtIndexPath indexPath: NSIndexPath) {
        tableView.deselectRowAtIndexPath(indexPath, animated: false)
    }

    func tableView(tableView: UITableView, indentationLevelForRowAtIndexPath indexPath: NSIndexPath) -> Int {
        return 0
    }
}