//
//  SimpleCollectionViewController.swift
//
//  Created by Naoki on 2014/11/04.
//  Copyright (c) 2014年 Naoki. All rights reserved.
//

import UIKit
import Foundation

/**
*  UICollectionViewのビューコントローラクラスです。
*  UICollectionViewDataSourceプロトコルとUICollectionViewDelegateプロトコルに適合しています。
*/
class SimpleCollectionViewController : UICollectionViewController, UICollectionViewDelegate, UICollectionViewDelegateFlowLayout, UICollectionViewDataSource {
    
    // 参考サイト@Objective-c
    // ttp://dev.classmethod.jp/smartphone/iphone/ios6-uicollectionview/
    
    override func viewDidLoad() {
        super.viewDidLoad()
    }
    
    // セクションの数
    override func numberOfSectionsInCollectionView(collectionView: UICollectionView) -> Int {
        return 1
    }
    
    // セクションのセル数
    override func collectionView(collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return 100
    }
    
    // セルの内容
    override func collectionView(collectionView: UICollectionView, cellForItemAtIndexPath indexPath: NSIndexPath) -> UICollectionViewCell {
        
        var myCell : UICollectionViewCell = collectionView.dequeueReusableCellWithReuseIdentifier("Cell", forIndexPath: indexPath) as UICollectionViewCell
        
        // Cellの背景色を変える
        myCell.backgroundColor = UIColor.whiteColor()
        
        return myCell
    }
    
}