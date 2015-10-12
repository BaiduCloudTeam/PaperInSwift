//
//  CHCollectionViewLargeLayout.swift
//  PaperInSwift
//
//  Created by PeterFeng on 10/11/15.
//  Copyright © 2015 Team_ChineseHamburger. All rights reserved.
//  Hallelujah

import UIKit
class CHCollectionViewLargeLayout: CHStickyHeaderLayout {
    override init() {
        super.init()
        self.setup()
    }
    
    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    override func awakeFromNib() {
        self.setup()
    }
    
    func setup() {
        self.itemSize = UIScreen.mainScreen().bounds.size
        self.sectionInset = UIEdgeInsetsMake(0, -CGRectGetWidth(UIScreen.mainScreen().bounds), 0, 2)
        self.minimumInteritemSpacing = 10.0
        self.minimumLineSpacing = 4.0
        self.scrollDirection = .Horizontal
        self.headerReferenceSize = UIScreen.mainScreen().bounds.size
        self.collectionView!.pagingEnabled = true
    }
    
    override func shouldInvalidateLayoutForBoundsChange(newBounds: CGRect) -> Bool {
        return true
    }
    
    override func targetContentOffsetForProposedContentOffset(proposedContentOffset: CGPoint, withScrollingVelocity velocity: CGPoint) -> CGPoint {
        var offsetAdjustment = CGFloat.max;
        let horizontalCenter:CGFloat = proposedContentOffset.x + (CGRectGetWidth(self.collectionView!.bounds) / 2.0)
        let targetRect:CGRect = CGRectMake(proposedContentOffset.x, 0.0, self.collectionView!.bounds.size.width, self.collectionView!.bounds.size.height);
        let array = self.layoutAttributesForElementsInRect(targetRect)
        for var layoutAttributes:UICollectionViewLayoutAttributes in array! {
            if layoutAttributes.representedElementCategory != .Cell {
                continue
            }
            let itemHorizontalCenter:CGFloat = layoutAttributes.center.x
            if (abs(itemHorizontalCenter-horizontalCenter)<abs(offsetAdjustment)) {
                offsetAdjustment = itemHorizontalCenter - horizontalCenter
                layoutAttributes.alpha = 0
            }
        }
        
        return CGPointMake(proposedContentOffset.x + offsetAdjustment, proposedContentOffset.y);
    }
    
    override func layoutAttributesForSupplementaryViewOfKind(elementKind: String, atIndexPath indexPath: NSIndexPath) -> UICollectionViewLayoutAttributes? {
        let attributes:UICollectionViewLayoutAttributes = super.layoutAttributesForSupplementaryViewOfKind(elementKind, atIndexPath: indexPath)!
        if elementKind == UICollectionElementKindSectionHeader {
            attributes.zIndex = -2
        }
        return attributes
    }
}
