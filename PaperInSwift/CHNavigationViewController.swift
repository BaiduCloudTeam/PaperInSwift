//
//  CHNavigationViewController.swift
//  PaperInSwift
//
//  Created by HX_Wang on 15/10/10.
//  Copyright © 2015年 Team_ChineseHamburger. All rights reserved.
//

import UIKit

public class CHNavigationViewController : UINavigationController, UINavigationControllerDelegate, CHControllerTransitionDelegate {
    private var transitionController : CHTranstionController?
//    required public init?(coder aDecoder: NSCoder) {
//        super.init(coder: aDecoder)
//        fatalError("init(coder:) has not been implemented")
//    }
    
    override public func viewDidLoad() {
        super.viewDidLoad()
        self.delegate = self
        self.navigationBar.setBackgroundImage(UIImage(), forBarMetrics:.Default)
        self.navigationBar.shadowImage = UIImage()
        self.navigationBar.translucent = true
        self.navigationBar.barTintColor = UIColor.whiteColor()
        self.navigationBar.tintColor = UIColor.whiteColor()
        self.navigationBar.titleTextAttributes = [NSForegroundColorAttributeName : UIColor.whiteColor()]
    }
    
    public func navigationController(navigationController: UINavigationController, willShowViewController viewController: UIViewController, animated: Bool) {
        if viewController.isKindOfClass(CHSmallCollectionViewController) && transitionController != nil {
            var collectionViewController = viewController as! CHSmallCollectionViewController
            transitionController = CHTranstionController(collectionView: collectionViewController.collectionView!)
            transitionController?.delegate = self
        }
    }
    
    override public func popViewControllerAnimated(animated: Bool) -> UIViewController? {
        if (self.topViewController?.isKindOfClass(CHSmallCollectionViewController) != nil) {
            transitionController = nil
        }
        return self.popViewControllerAnimated(animated)
    }
    
    override public func preferredStatusBarStyle() -> UIStatusBarStyle {
        return .LightContent
    }
    
    public func interactionBeganAtPoint(origin : CGPoint) {
         let presentingViewController = self.topViewController as! CHSmallCollectionViewController
         let presentedViewController = presentingViewController.nextViewControllerAtPoint(origin)
        if let vc : UIViewController? = presentedViewController {
             self.pushViewController(vc!, animated: true)
         }else {
             self.popViewControllerAnimated(true)
         }
    }
    
    public func navigationController(navigationController: UINavigationController, animationControllerForOperation operation: UINavigationControllerOperation, fromViewController fromVC: UIViewController, toViewController toVC: UIViewController) -> UIViewControllerAnimatedTransitioning? {
        if !fromVC.isKindOfClass(UICollectionViewController) || !toVC.isKindOfClass(UICollectionViewController) {
            return nil
        }
        if (transitionController?.hasActiveInteraction != nil) {
            return nil
        }
        transitionController?.navigationOperation = operation
        return transitionController
    }
    
    override public func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
    }
}
