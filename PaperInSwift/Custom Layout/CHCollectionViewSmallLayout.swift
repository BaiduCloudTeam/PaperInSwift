//
//  CHCollectionViewSmallLayout.swift
//  PaperInSwift
//
//  Created by PeterFrank on 10/11/15.
//  Copyright © 2015 Team_ChineseHamburger. All rights reserved.
//  Good Night

import UIKit
class CHCollectionViewSmallLayout: CHStickyHeaderLayout {
    override init() {
        super.init()
        self.setup()
    }

    required init?(coder aDecoder: NSCoder) {
        super.init(coder: aDecoder)
    }
    
    override func awakeFromNib() {
        self.setup()
    }
    
    func setup() {
        self.itemSize = CGSizeMake(142, 254)
        let top:CGFloat = isiPhone5() ? 314 : 224
        self.sectionInset = UIEdgeInsetsMake(top, -CGRectGetWidth(UIScreen.mainScreen().bounds), 0, 2)
        self.minimumInteritemSpacing = 10.0
        self.minimumLineSpacing = 2.0
        self.scrollDirection = .Horizontal
        self.headerReferenceSize = UIScreen.mainScreen().bounds.size
        self.collectionView!.pagingEnabled = false
    }
    
    override func shouldInvalidateLayoutForBoundsChange(newBounds: CGRect) -> Bool {
        return true
    }
    
    func isiPhone5() ->Bool {
        return UIScreen.mainScreen().currentMode?.size == CGSizeMake(640, 1136)
    }
}