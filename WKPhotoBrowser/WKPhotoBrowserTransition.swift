//
//  WKPhotoBrowserTransition.swift
//  WKPhotoBrowser
//
//  Created by 秦 道平 on 14/12/13.
//  Copyright (c) 2014年 秦 道平. All rights reserved.
//

import UIKit

class WKPhotoBrowserTransition: NSObject,UIViewControllerAnimatedTransitioning {
    func transitionDuration(transitionContext: UIViewControllerContextTransitioning) -> NSTimeInterval {
        return 0.3
    }
    func animateTransition(transitionContext: UIViewControllerContextTransitioning) {
        let toVc = transitionContext.viewControllerForKey(UITransitionContextToViewControllerKey)! as WKPhotoBrowserNavigationViewController
        let fromVc = transitionContext.viewControllerForKey(UITransitionContextFromViewControllerKey)! as UINavigationController
        toVc.view.alpha = 0.0
        let containerView = transitionContext.containerView()
        containerView.addSubview(toVc.view)
        
//        let listVc = fromVc.topViewController as WKPhotoBrowserListViewController
//        let snapView = listVc.snapView!
//        containerView.addSubview(snapView)
        
        let duration = self.transitionDuration(transitionContext)
        UIView.animateWithDuration(duration, animations: { () -> Void in
//            toVc.view.alpha = 1.0
            }) { (completed) -> Void in
                toVc.view.alpha = 1.0 ///在viewDidAppeared 之后会调用这里
                transitionContext.completeTransition(true)
        }
    }
}
