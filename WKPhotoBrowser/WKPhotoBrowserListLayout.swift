//
//  WKPhotoBrowserListLayout.swift
//  WKPhotoBrowser
//
//  Created by 秦 道平 on 14/12/12.
//  Copyright (c) 2014年 秦 道平. All rights reserved.
//

import UIKit

class WKPhotoBrowserListLayout: UICollectionViewFlowLayout {
    override func prepareLayout() {
        super.prepareLayout()
        self.itemSize = CGSizeMake(100 , 100.0)
        self.minimumLineSpacing = 5.0
        self.minimumInteritemSpacing = 5.0
        self.scrollDirection = UICollectionViewScrollDirection.Vertical
    }
    override func collectionViewContentSize() -> CGSize {
        let items = self.collectionView!.numberOfItemsInSection(0)
        var lines = Int(items / 3)
        if (items % 3) > 0 {
            lines += 1
        }
        let height = CGFloat(lines * (100+5)) + 44.0
        return CGSizeMake(self.collectionView!.frame.size.width, height)
    }
    override func shouldInvalidateLayoutForBoundsChange(newBounds: CGRect) -> Bool {
        return true
    }
}
