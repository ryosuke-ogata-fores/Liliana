//
//  ImageCollectionViewController.swift
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
class ImageCollectionViewController : UICollectionViewController, UICollectionViewDelegate, UICollectionViewDelegateFlowLayout, UICollectionViewDataSource {
    
    // 参考サイト
    // ttps://github.com/hiroto-yamashita/swift-collectionview/blob/master/CollectionViewTutorial/MyCollectionViewController.swift
    
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
        
        var myCell : ImageCollectionViewCell = collectionView.dequeueReusableCellWithReuseIdentifier("Cell", forIndexPath: indexPath) as ImageCollectionViewCell
        
        // Cellに画像をセットする
        myCell.imageView.image = UIImage(named:"yukikotan")
        
        // Cellの背景色を変える
        myCell.backgroundColor = UIColor.whiteColor()
        
        return myCell
    }
    
}