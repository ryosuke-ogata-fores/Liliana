//
//  ImageCollectionViewCell.swift
//
//  Created by Naoki on 2014/11/05.
//  Copyright (c) 2014年 Naoki. All rights reserved.
//

import UIKit
import Foundation

/**
 *  UICollectionReusableViewを継承した、個々の要素をセルとして表示するためのUIコンポーネントです。
 *  UITableViewCellと違ってラベルなどを一切持っていないので、文字を表示したい場合などは継承して必要なUIコンポーネントを追加します。
 */
class ImageCollectionViewCell : UICollectionViewCell {
    // セルの中のUIImageView
    @IBOutlet weak var imageView: UIImageView!
    
    
}