//
//  ArticleModel.swift
//  Liliana
//
//  Created by rogata on 10/30/14.
//  Copyright (c) 2014 rogata. All rights reserved.
//

import Foundation
/**
 *  記事モデル
 */
class ArticleModel {
    var id:UInt!
    var title:String!
    var imgUrl:String!
    var content:String!
    var linkUrl:String!
    var publishDate:NSDate!
    init(dict:[String:AnyObject]) {
        id = dict["id"] as UInt
        title = dict["title"] as String
        imgUrl = dict["imgUrl"] as String
        content = dict["content"] as String
        linkUrl = dict["linkUrl"] as String
        var fmt = NSDateFormatter()
        fmt.timeZone = NSTimeZone.defaultTimeZone()
        fmt.dateFormat = "yyyy/MM/dd HH:mm:ss"
        publishDate = fmt.dateFromString(dict["publishDate"] as String)
    }
}