//
//  WKPhotoBrowserCell.swift
//  WKPhotoBrowser
//
//  Created by 秦 道平 on 14/12/9.
//  Copyright (c) 2014年 秦 道平. All rights reserved.
//

import UIKit

class WKPhotoBrowserCell: UICollectionViewCell {
    @IBOutlet weak var titleLabel:UILabel!
    @IBOutlet weak var scrollView:UIScrollView!
    @IBOutlet weak var titleConstraintTop:NSLayoutConstraint!
    @IBOutlet weak var titleConstraintRight:NSLayoutConstraint!
    @IBOutlet weak var titleConstraintBottom:NSLayoutConstraint!
    @IBOutlet weak var titleConstraintLeft:NSLayoutConstraint!
    @IBOutlet weak var titleConstraintWidth:NSLayoutConstraint!
    @IBOutlet weak var titleConstraintHeight:NSLayoutConstraint!
    override func updateConstraints() {
        let titleLabelWidth:CGFloat = self.frame.size.width
        let titleLabelHeight:CGFloat = 44.0
        self.titleConstraintWidth.constant = titleLabelWidth
        self.titleConstraintHeight.constant = titleLabelHeight
        var top:CGFloat = (self.frame.size.height - titleLabelHeight) / 2.0
        top = fmax(top, 0.0)
        var bottom = top
        var left:CGFloat = (self.frame.size.width - titleLabelWidth) / 2.0
        var right:CGFloat = left
        self.titleConstraintTop.constant = top
        self.titleConstraintRight.constant = right
        self.titleConstraintBottom.constant = bottom
        self.titleConstraintLeft.constant = left
        self.layoutIfNeeded()
        NSLog("frame:%@,top:%@,right:%@,bottom:%@,right:%@,width:%@,height:%@,scrollContentSize:%@",
            NSStringFromCGRect(self.frame),
            top,right,bottom,left,titleLabelWidth,titleLabelHeight,
            NSStringFromCGSize(self.scrollView.contentSize))
        super.updateConstraints()
    }
}
