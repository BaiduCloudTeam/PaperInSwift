//
//  CHPaperCollectionViewController.swift
//  PaperInSwift
//
//  Created by Peter Frank on 15/10/12.
//  Copyright © 2015年 Team_ChineseHamburger. All rights reserved.
//  Uptown Funk

import UIKit

class CHPaperCollectionViewController:UICollectionViewController {
    var count = 0
    var header:CHSectionHeader?
    
    func nextViewControllerAtPoint(point:CGPoint) ->UICollectionViewController {
        return self
    }
    
    //MARK View lifecycle
    override func viewDidLoad() {
        super.viewDidLoad()
        self.collectionView?.registerClass(UICollectionViewCell.classForCoder(), forCellWithReuseIdentifier:"CELL_ID")
        self.collectionView?.backgroundColor = UIColor.clearColor()
        self.collectionView?.registerNib(UINib(nibName:"CHSectionHeader", bundle: nil), forSupplementaryViewOfKind: UICollectionElementKindSectionHeader, withReuseIdentifier: "header")
        self.collectionView?.contentInset = UIEdgeInsetsMake(0, 0, 0, 0)
        self.automaticallyAdjustsScrollViewInsets = false
        self.collectionView?.delaysContentTouches = false
        self.count = 20
    }
    
    override func viewWillAppear(animated: Bool) {
        super.viewWillAppear(animated)
        self.collectionView?.decelerationRate = self.classForCoder != CHPaperCollectionViewController.classForCoder() ? UIScrollViewDecelerationRateNormal:UIScrollViewDecelerationRateFast
    }
    
    override func prefersStatusBarHidden() -> Bool {
        self.navigationController?.setNavigationBarHidden(true, animated: true)
        return true
    }
    
    //MARK Delegate
    override func collectionView(collectionView: UICollectionView, cellForItemAtIndexPath indexPath: NSIndexPath) -> UICollectionViewCell {
        let cell:UICollectionViewCell = collectionView.dequeueReusableCellWithReuseIdentifier("CELL_ID", forIndexPath: indexPath)
        cell.backgroundColor = UIColor.whiteColor()
        cell.layer.cornerRadius = 4
        cell.clipsToBounds = true
        
        let backgroundView:UIImageView = UIImageView(image: UIImage(named:"fake-cell"))
        cell.backgroundView = backgroundView
        return cell
    }
    
    override func collectionView(collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return self.count
    }
    
    override func numberOfSectionsInCollectionView(collectionView: UICollectionView) -> Int {
        return 1
    }
    
    override func collectionView(collectionView: UICollectionView, transitionLayoutForOldLayout fromLayout: UICollectionViewLayout, newLayout toLayout: UICollectionViewLayout) -> UICollectionViewTransitionLayout {
        let transitionLayout:CHTransitionLayout = CHTransitionLayout(currentLayout: fromLayout, nextLayout:toLayout)
        return transitionLayout
    }
    
    override func collectionView(collectionView: UICollectionView, viewForSupplementaryElementOfKind kind: String, atIndexPath indexPath: NSIndexPath) -> UICollectionReusableView {
        
        guard let _ = self.header else {
            self.header = collectionView.dequeueReusableSupplementaryViewOfKind(kind, withReuseIdentifier: "header", forIndexPath: indexPath) as? CHSectionHeader
            let callback:(NSInteger) -> Void = {
                [unowned self]
                (arg) -> Void  in
                self.count = Int(arc4random_uniform(20))+3;
                self.collectionView?.scrollToItemAtIndexPath(NSIndexPath(forRow:0, inSection:0), atScrollPosition: UICollectionViewScrollPosition.Left, animated: false)
                self.collectionView?.reloadSections(NSIndexSet(index: 0))
            }
            self.header?.didPageControllerChanged = callback
            return self.header!
        }
        
        return self.header!
    }
}