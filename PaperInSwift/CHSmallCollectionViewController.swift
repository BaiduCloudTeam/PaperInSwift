//
//  CHSmallCollectionViewController.swift
//  PaperInSwift
//
//  Created by Peter Frank on 15/10/12.
//  Copyright © 2015年 Team_ChineseHamburger. All rights reserved.
//  Fresh Meat, delicious!

import UIKit
class CHSmallCollectionViewController: CHPaperCollectionViewController {
    var slide:Int?
    var mainView:UIView?
    var topImage:UIImageView?
    var reflected:UIImageView?
    
    override func prefersStatusBarHidden() -> Bool {
        self.navigationController?.setNavigationBarHidden(false, animated: true)
        return false
    }

    override func collectionView(collectionView: UICollectionView, didSelectItemAtIndexPath indexPath: NSIndexPath) {
        let vc:UIViewController = self.nextViewControllerAtPoint(CGPointZero)
        self.navigationController?.pushViewController(vc, animated: true)
    }
    
    override func nextViewControllerAtPoint(point: CGPoint) -> UICollectionViewController {
        let largeLayout:CHCollectionViewLargeLayout = CHCollectionViewLargeLayout()
        let nextCollectionViewController:CHPaperCollectionViewController = CHPaperCollectionViewController(collectionViewLayout: largeLayout)
        nextCollectionViewController.useLayoutToLayoutNavigationTransitions = true
        return nextCollectionViewController
    }
}
