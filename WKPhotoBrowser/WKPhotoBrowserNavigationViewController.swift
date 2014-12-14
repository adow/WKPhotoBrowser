//
//  WKPhotoBrowserNavigationViewController.swift
//  WKPhotoBrowser
//
//  Created by 秦 道平 on 14/12/13.
//  Copyright (c) 2014年 秦 道平. All rights reserved.
//

import UIKit

class WKPhotoBrowserNavigationViewController: UINavigationController,UIViewControllerTransitioningDelegate {
    override func viewDidLoad() {
        super.viewDidLoad()
        self.transitioningDelegate = self
    }
    func animationControllerForDismissedController(dismissed: UIViewController) -> UIViewControllerAnimatedTransitioning? {
        return nil
    }
    func animationControllerForPresentedController(presented: UIViewController, presentingController presenting: UIViewController, sourceController source: UIViewController) -> UIViewControllerAnimatedTransitioning? {
        return WKPhotoBrowserTransition()
    }
}
