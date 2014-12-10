//
//  WKPhotoBrowserCell.swift
//  WKPhotoBrowser
//
//  Created by 秦 道平 on 14/12/9.
//  Copyright (c) 2014年 秦 道平. All rights reserved.
//

import UIKit

class WKPhotoBrowserCell: UICollectionViewCell,UIScrollViewDelegate {
    @IBOutlet weak var titleLabel:UILabel!
    @IBOutlet weak var scrollView:UIScrollView!
    @IBOutlet weak var titleConstraintTop:NSLayoutConstraint!
    @IBOutlet weak var titleConstraintRight:NSLayoutConstraint!
    @IBOutlet weak var titleConstraintBottom:NSLayoutConstraint!
    @IBOutlet weak var titleConstraintLeft:NSLayoutConstraint!
    @IBOutlet weak var titleConstraintWidth:NSLayoutConstraint!
    @IBOutlet weak var titleConstraintHeight:NSLayoutConstraint!
    @IBOutlet weak var imageViewConstraintTop:NSLayoutConstraint!
    @IBOutlet weak var imageViewConstraintRight:NSLayoutConstraint!
    @IBOutlet weak var imageViewConstraintBottom:NSLayoutConstraint!
    @IBOutlet weak var imageViewConstraintLeft:NSLayoutConstraint!
    @IBOutlet weak var imageViewConstraintWidth:NSLayoutConstraint!
    @IBOutlet weak var imageViewConstraintHeight:NSLayoutConstraint!
    @IBOutlet weak var imageView:UIImageView!
    weak var collectionViewOnwer:UICollectionView!
    var initRatio : CGFloat = 1.0
    override func awakeFromNib() {
        super.awakeFromNib()
        let tapGesture = UITapGestureRecognizer(target: self, action: Selector("onTapGesture:"))
        tapGesture.numberOfTapsRequired = 2
        self.addGestureRecognizer(tapGesture)
    }
//    override func updateConstraints() {
//        let titleLabelWidth:CGFloat = self.frame.size.width
//        let titleLabelHeight:CGFloat = 44.0
//        self.titleConstraintWidth.constant = titleLabelWidth
//        self.titleConstraintHeight.constant = titleLabelHeight
//        var top:CGFloat = (self.frame.size.height - titleLabelHeight) / 2.0
//        top = fmax(top, 0.0)
//        var bottom = top
//        var left:CGFloat = (self.frame.size.width - titleLabelWidth) / 2.0
//        var right:CGFloat = left
//        self.titleConstraintTop.constant = top
//        self.titleConstraintRight.constant = right
//        self.titleConstraintBottom.constant = bottom
//        self.titleConstraintLeft.constant = left
//        self.layoutIfNeeded()
//        NSLog("frame:%@,top:%@,right:%@,bottom:%@,right:%@,width:%@,height:%@,scrollContentSize:%@",
//            NSStringFromCGRect(self.frame),
//            top,right,bottom,left,titleLabelWidth,titleLabelHeight,
//            NSStringFromCGSize(self.scrollView.contentSize))
//        super.updateConstraints()
//    }
    override func updateConstraints() {
        NSLog("viewSize:%@,scrollSize:%@", NSStringFromCGSize(self.frame.size),NSStringFromCGSize(self.scrollView.frame.size))
        let image = imageView.image!
        let imageSize = image.size
        let scrollViewSize = self.scrollView.frame.size
        var target_image_width : CGFloat = 0.0
        var target_image_height : CGFloat = 0.0
        if imageSize.width <= imageSize.height {
            target_image_width = scrollViewSize.width
            target_image_width = fmin(target_image_width,imageSize.width)
            target_image_height = imageSize.height / imageSize.width * target_image_width
        }
        else{
            target_image_height = scrollViewSize.height
            target_image_height = fmin(target_image_height, imageSize.height)
            target_image_width = imageSize.width * target_image_height / imageSize.height
        }
        ///不但要修改约束条件，还要修改 imageView 的尺寸
        var imageViewFrame = self.imageView.frame
        imageViewFrame.size.width = target_image_width
        imageViewFrame.size.height = target_image_height
        self.imageView.frame = imageViewFrame
        let left_margin : CGFloat = (scrollViewSize.width - target_image_width ) / 2.0
        let right_margin = left_margin
        let top_margin : CGFloat = (scrollViewSize.height - target_image_height) / 2.0
        let bottom_margin = top_margin
        self.imageViewConstraintTop.constant = top_margin
        self.imageViewConstraintRight.constant = right_margin
        self.imageViewConstraintBottom.constant = bottom_margin
        self.imageViewConstraintLeft.constant = left_margin
        self.imageViewConstraintWidth.constant = target_image_width
        self.imageViewConstraintHeight.constant = target_image_height
        
        ///maxZoom，放到最大就是图片的大小
        let maxWidthRatio = imageSize.width / target_image_width
        let maxHeightRatio = imageSize.height / target_image_height
        var maxRatio = (maxWidthRatio > maxHeightRatio) ? maxHeightRatio : maxWidthRatio
        maxRatio = fmax(maxRatio, 1.0)
        self.scrollView.maximumZoomScale = maxRatio
//        self.scrollView.zoomScale = self.scrollView.maximumZoomScale
        super.updateConstraints()
//        self.layoutIfNeeded()
    }
    ///触摸控制，放大缩小
    @IBAction func onTapGesture(gesture:UITapGestureRecognizer){
//        self.scrollView.zoomScale = 3.0
//        self.layoutIfNeeded()
        UIView.animateWithDuration(0.1, animations: { [unowned self]() -> Void in
            if self.scrollView.zoomScale != self.scrollView.maximumZoomScale {
                NSLog("zoom:%@", self.scrollView.maximumZoomScale)
                self.scrollView.scrollEnabled = true
                self.collectionViewOnwer.scrollEnabled = false
                self.scrollView.zoomScale = self.scrollView.maximumZoomScale
            }
            else{
                NSLog("zoom : 1")
                self.scrollView.scrollEnabled = false
                self.collectionViewOnwer.scrollEnabled = true
                self.scrollView.zoomScale = 1.0
            }
        })
        
    }
    ///MARK: - UIScrollViewDelegate
    func viewForZoomingInScrollView(scrollView: UIScrollView) -> UIView? {
        return self.imageView
    }
    func scrollViewDidZoom(scrollView: UIScrollView) {
        //self.updateConstraints()
    }
}
