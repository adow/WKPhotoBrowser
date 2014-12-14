//
//  WKPhotoBrowserListViewController.swift
//  WKPhotoBrowser
//
//  Created by 秦 道平 on 14/12/12.
//  Copyright (c) 2014年 秦 道平. All rights reserved.
//

import UIKit
let cell_identifier = "photo-cell"
class WKPhotoBrowserListViewController: UIViewController,UICollectionViewDataSource,UICollectionViewDelegate {
    lazy var photos:[UIImage] = {
        var images = [UIImage]()
        for a in 0...14 {
            let image = UIImage(named:"\(a)")
            images.append(image!)
        }
        return images
        }()
    @IBOutlet weak var collectionView:UICollectionView!
    weak var snapView:UIView?
    override func viewDidLoad() {
        super.viewDidLoad()

        // Do any additional setup after loading the view.
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    func make_square_image(image:UIImage!,width:CGFloat)->UIImage{
        let old_image_size = image.size
        var image_clip_width :CGFloat = 0.0
        var image_clip_height :CGFloat = 0.0
        if old_image_size.width >= old_image_size.height {
            image_clip_height = old_image_size.height
            image_clip_width = image_clip_height
        }
        else{
            image_clip_width = old_image_size.width
            image_clip_height = image_clip_width
        }
        var top:CGFloat = (old_image_size.height - image_clip_height) / 2.0
        var left:CGFloat = (old_image_size.width - image_clip_width) / 2.0
        let clip_image = CGImageCreateWithImageInRect(image.CGImage, CGRect(x: left, y: top, width: image_clip_width, height: image_clip_height))
        UIGraphicsBeginImageContext(CGSize(width: width, height: width))
        let context = UIGraphicsGetCurrentContext()
        CGContextSaveGState(context);
        // Flip the coordinate system
        CGContextSetTextMatrix(context, CGAffineTransformIdentity); // 2-1
        CGContextTranslateCTM(context, 0, width); // 3-1
        CGContextScaleCTM(context, 1.0, -1.0); // 4-1
        CGContextSetFillColorWithColor(context, UIColor.whiteColor().CGColor)
        UIRectFill(CGRect(x: 0.0, y: 0.0, width: width, height: width))
        CGContextDrawImage(context, CGRect(x: 0, y: 0, width: width, height: width), clip_image)
//        image.drawAtPoint(CGPoint(x: 0.0, y: 0.0))
//        image.drawInRect(CGRect(x: 0.0, y: 0.0, width: width, height: width))
        let new_image = UIGraphicsGetImageFromCurrentImageContext()
        CGContextRestoreGState(context);
        UIGraphicsEndImageContext()
        return new_image
    }
    func numberOfSectionsInCollectionView(collectionView: UICollectionView) -> Int {
        return 1
    }
    func collectionView(collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return self.photos.count
    }
    func collectionView(collectionView: UICollectionView, cellForItemAtIndexPath indexPath: NSIndexPath) -> UICollectionViewCell {
        let cell = collectionView.dequeueReusableCellWithReuseIdentifier(cell_identifier, forIndexPath: indexPath) as WKPhotoBrowserListCell
        let image = self.photos[indexPath.row];
//        let square = self.make_square_image(image, width: 100.0)
//        cell.imageView.image = square
        cell.imageView.image = image
        return cell
    }
    // MARK: - Navigation

    // In a storyboard-based application, you will often want to do a little preparation before navigation
    override func prepareForSegue(segue: UIStoryboardSegue, sender: AnyObject?) {
        // Get the new view controller using segue.destinationViewController.
        // Pass the selected object to the new view controller.
        let indexPath = self.collectionView.indexPathsForSelectedItems()![0] as NSIndexPath
        let cell = self.collectionView.cellForItemAtIndexPath(indexPath)
        self.snapView = cell!.snapshotViewAfterScreenUpdates(true)
//        self.snapView!.frame = cell!.convertRect(cell!.frame, toView: self.view)
        let top = cell!.frame.origin.y + 128.0 + self.collectionView.contentOffset.y
        var rect = cell!.frame
        rect.origin.y = top
        self.snapView!.frame = rect
        let navigationController = segue.destinationViewController as UINavigationController
        let browserViewController = navigationController.childViewControllers[0] as ViewController
        browserViewController.photoIndex = (self.collectionView.indexPathsForSelectedItems()![0] as NSIndexPath).row
    }

}
