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
        // 日付フォーマッター
        var fmt:NSDateFormatter = NSDateFormatter()
        fmt.locale = NSLocale(localeIdentifier: "ja_JP");
        fmt.dateFormat = "yyyy/MM/dd HH:mm:ss"
        for i in 0...20 {
            var num:Int! = i + 1
            var additionDay:Int! = 60 * 60 * 24 * num
            var millis:Int = Int(NSDate().timeIntervalSince1970) + additionDay!
            var d:NSDate = NSDate(timeIntervalSince1970: NSTimeInterval(millis))
            var dict:[String:AnyObject] = [
                "id": 1,
                "title": "Swift(* '-')ノ",
                "imgUrl": (i % 2 == 0) ? "a": "http://cdn3.iconfinder.com/data/icons/free-social-icons/67/linkedin_square_color-128.png",
                "content": "Swift is an innovative new programming language for Cocoa and Cocoa Touch.",
                "linkUrl": "https://developer.apple.com/swift/",
                "publishDate": fmt.stringFromDate(d)
            ]
            var model:ArticleModel = ArticleModel(dict:dict)
            articles.append(model)
        }
        self.articles = articles
//        // StoryBoardで紐づけているのでいらない
//        self.tableView.delegate  = self
//        self.tableView.dataSource = self
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
        tableView.cellForRowAtIndexPath(indexPath)?.setEditing(true, animated: true)
    }

    func tableView(tableView: UITableView, indentationLevelForRowAtIndexPath indexPath: NSIndexPath) -> Int {
        return 0
    }
}