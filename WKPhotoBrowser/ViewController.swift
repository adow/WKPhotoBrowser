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
    var photoIndex:Int!
    @IBOutlet weak var collectionView:UICollectionView!
    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view, typically from a nib.
    }
    override func viewWillAppear(animated: Bool) {
        super.viewWillAppear(animated)

    }
    override func viewDidAppear(animated: Bool) {
        super.viewDidAppear(animated)
        self.collectionView.scrollToItemAtIndexPath(NSIndexPath(forItem: self.photoIndex, inSection: 0), atScrollPosition: UICollectionViewScrollPosition.CenteredHorizontally, animated: false) ///只有在viewDidAppear 中调用滚动才用
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
    @IBAction func onButtonCancel(sender:UIBarButtonItem!){
        self.navigationController?.dismissViewControllerAnimated(true, completion: { () -> Void in
            
        })
    }

//    func numberOfSectionsInCollectionView(collectionView: UICollectionView) -> Int {
//        return 1
//    }
    func collectionView(collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return self.photos.count
    }
    func collectionView(collectionView: UICollectionView, cellForItemAtIndexPath indexPath: NSIndexPath) -> UICollectionViewCell {
        let cell = collectionView.dequeueReusableCellWithReuseIdentifier("photo-cell", forIndexPath: indexPath) as WKPhotoBrowserCell
        cell.layoutIfNeeded() ///要先调用一次layoutIfNeeded()，否则开始的几个cell的宽度还没有改变
        cell.collectionViewOnwer = collectionView
        cell.imageView.image = self.photos[indexPath.row]
        cell.setupConstraints() ///根据图片设置新的约束条件
        return cell
    }

}

