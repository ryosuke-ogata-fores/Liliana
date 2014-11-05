//
//  MyTableViewController.swift
//  Liliana
//
//  Created by rogata on 10/29/14.
//  Copyright (c) 2014 rogata. All rights reserved.
//

import UIKit

/**
セクション

- Today:     今日の記事
- Yesterday: 昨日の記事
- Tomorrow:  明日の記事
- Limit:     セクション数
*/
enum ArticleSection : Int {
    case Today = 0
    case Yesterday
    case Tomorrow
    case Limit
}

class MyTableViewController: UIViewController, UITableViewDelegate, UITableViewDataSource {

    @IBOutlet weak var tableView: UITableView!
    
    var articlesToday:[ArticleModel] = []
    var articlesYesterday:[ArticleModel] = []
    var articlesTomorrow:[ArticleModel] = []

    override func viewDidLoad() {
        super.viewDidLoad()
        self.tableView.registerNib(UINib(nibName: "ArticleCell", bundle: nil), forCellReuseIdentifier: ArticleCell.cellIdentifier())
    }
    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
    }
    override func viewDidAppear(animated: Bool) {
        super.viewDidAppear(animated)
        // --- 仮データを作る(本当のプロジェクトだとAPI呼び出しで作るとか) ---
        // 日付フォーマッター
        var fmt:NSDateFormatter = NSDateFormatter()
        fmt.locale = NSLocale(localeIdentifier: "ja_JP");
        fmt.dateFormat = "yyyy/MM/dd HH:mm:ss"
        // これから作るセクション数でループ（3個）
        for i in 0..<ArticleSection.Limit.rawValue {
            var num:Int! = i + 1
            var additionDay:Int! = 60 * 60 * 24 * i
            var millis:Int = Int(NSDate().timeIntervalSince1970) + additionDay!
            var d:NSDate = NSDate(timeIntervalSince1970: NSTimeInterval(millis))
            var publishDateString:String = fmt.stringFromDate(d)
            // これから作るセクション毎の件数でループ（1〜15個のランダム）
            for j in 0..<Int(rand() % 14) + 1 {
                var dict:[String:AnyObject] = [
                    "id": 1,
                    "title": "Swift(* '-')ノ",
                    "content": "Swift is an innovative new programming language for Cocoa and Cocoa Touch.",
                    "linkUrl": "https://developer.apple.com/swift/",
                    "publishDate": publishDateString
                ]
                switch i {
                case ArticleSection.Today.rawValue:
                    dict["imgUrl"] = "http://cdn.flaticon.com/png/256/11296.png"
                    self.articlesToday.append(ArticleModel(dict:dict))
                    break
                case ArticleSection.Yesterday.rawValue:
                    dict["imgUrl"] = "http://cdn.flaticon.com/png/256/11030.png"
                    self.articlesYesterday.append(ArticleModel(dict:dict))
                    break
                case ArticleSection.Tomorrow.rawValue:
                    dict["imgUrl"] = "http://cdn.flaticon.com/png/256/10915.png"
                    self.articlesTomorrow.append(ArticleModel(dict:dict))
                    break
                default:
                    break
                }
            }
        }
        // tableViewの再描画
        self.tableView.reloadData()
    }
    
    func tableView(tableView: UITableView, heightForRowAtIndexPath indexPath: NSIndexPath) -> CGFloat {
        return ArticleCell.cellHeight()
    }
    
    func tableView(tableView: UITableView, heightForHeaderInSection section: Int) -> CGFloat {
        return 32
    }

    func tableView(tableView: UITableView, heightForFooterInSection section: Int) -> CGFloat {
        return 0.000001
    }

    func tableView(tableView: UITableView, viewForHeaderInSection section: Int) -> UIView? {
        var label:UILabel = UILabel()
        label.frame = CGRectMake(0, 0, CGRectGetWidth(self.tableView.frame), 32)
        label.backgroundColor = UIColor.grayColor()
        label.textColor = UIColor.whiteColor()
        label.text = "header"
        switch section {
        case ArticleSection.Today.rawValue:
            label.text = "Today"
            break
        case ArticleSection.Yesterday.rawValue:
            label.text = "Yesterday"
            break
        case ArticleSection.Tomorrow.rawValue:
            label.text = "Tomorrow"
            break
        default:
            break
        }
        return label
    }

    func tableView(tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        var ret:Int = 0
        switch section {
        case ArticleSection.Today.rawValue:
            ret = self.articlesToday.count
            break
        case ArticleSection.Yesterday.rawValue:
            ret = self.articlesYesterday.count
            break
        case ArticleSection.Tomorrow.rawValue:
            ret = self.articlesTomorrow.count
            break
        default:
            break
        }
        return ret
    }

    func tableView(tableView: UITableView, cellForRowAtIndexPath indexPath: NSIndexPath) -> UITableViewCell {
        let cell:ArticleCell = tableView.dequeueReusableCellWithIdentifier(ArticleCell.cellIdentifier(), forIndexPath: indexPath) as ArticleCell
        cell.setArticleModel(self.getArticleModelWithIndexPath(indexPath))
        return cell
    }
    
    func numberOfSectionsInTableView(tableView: UITableView) -> Int {
        return ArticleSection.Limit.rawValue
    }
    
    func tableView(tableView: UITableView, didSelectRowAtIndexPath indexPath: NSIndexPath) {
        tableView.deselectRowAtIndexPath(indexPath, animated: false)
    }

    func getArticleModelWithIndexPath(indexPath:NSIndexPath) -> ArticleModel {
        var ret:ArticleModel!
        switch indexPath.section {
        case ArticleSection.Today.rawValue:
            ret = self.articlesToday[indexPath.row]
            break
        case ArticleSection.Yesterday.rawValue:
            ret = self.articlesYesterday[indexPath.row]
            break
        case ArticleSection.Tomorrow.rawValue:
            ret = self.articlesTomorrow[indexPath.row]
            break
        default:
            break
        }
        return ret
    }
}