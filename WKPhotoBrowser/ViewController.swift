//
//  ViewController.swift
//  WKPhotoBrowser
//
//  Created by 秦 道平 on 14/12/9.
//  Copyright (c) 2014年 秦 道平. All rights reserved.
//

import UIKit

class ViewController: UIViewController,UICollectionViewDataSource,UICollectionViewDelegate {

    lazy var photos:[UIImage] = {
        var images = [UIImage]()
        for a in 0...14 {
            let image = UIImage(named:"\(a)")
            images.append(image!)
        }
        return images
    }()
    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view, typically from a nib.
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }

//    func numberOfSectionsInCollectionView(collectionView: UICollectionView) -> Int {
//        return 1
//    }
    func collectionView(collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return self.photos.count
    }
    func collectionView(collectionView: UICollectionView, cellForItemAtIndexPath indexPath: NSIndexPath) -> UICollectionViewCell {
        let cell = collectionView.dequeueReusableCellWithReuseIdentifier("photo-cell", forIndexPath: indexPath) as WKPhotoBrowserCell
        cell.layoutIfNeeded()
        cell.collectionViewOnwer = collectionView
//        cell.titleLabel.text = "cell - \(indexPath.row)"
//        cell.imageView.image = UIImage(named: "original")
        cell.imageView.image = self.photos[indexPath.row]

        cell.setupConstraints()
        return cell
    }

}

