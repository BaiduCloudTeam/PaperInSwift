//
//  CHStickyHeaderLayout.swift
//  PaperInSwift
//
//  Created by PeterFrank on 10/11/15.
//  Copyright © 2015 Team_ChineseHamburger. All rights reserved.
//  Winter is Coming

import UIKit

class CHStickyHeaderLayout:UICollectionViewFlowLayout {
    
    override func layoutAttributesForElementsInRect(rect: CGRect) -> [UICollectionViewLayoutAttributes]? {
        let anwser = super.layoutAttributesForElementsInRect(rect)
        let missingSections = NSMutableIndexSet()
        if var anwsers = anwser {
            for var idx in 0..<anwsers.count {
                let layoutAttributes = anwsers[idx] as UICollectionViewLayoutAttributes
                if layoutAttributes.representedElementCategory == .Cell {
                    missingSections.addIndex(layoutAttributes.indexPath.section)
                }
                if layoutAttributes.representedElementKind == UICollectionElementKindSectionHeader {
                    anwsers.removeAtIndex(idx)
                    idx--
                }
            }
            missingSections.enumerateIndexesUsingBlock { (Int idx, Bool stop) -> Void in
                let indexPath = NSIndexPath(forRow: 0, inSection: idx)
                let layoutAttributes = self.layoutAttributesForSupplementaryViewOfKind(UICollectionElementKindSectionHeader, atIndexPath: indexPath)
                if let constantLayoutAttributes = layoutAttributes {
                    anwsers.append(constantLayoutAttributes)
                }
                
            }
            return anwsers
        }
        return anwser
    }
    
    override func layoutAttributesForSupplementaryViewOfKind(elementKind: String, atIndexPath indexPath: NSIndexPath) -> UICollectionViewLayoutAttributes? {
        let attributes = super.layoutAttributesForSupplementaryViewOfKind(elementKind, atIndexPath: indexPath)
        if elementKind == UICollectionElementKindSectionHeader {
            let contentOffset:CGPoint = (self.collectionView?.contentOffset)!
            var nextHeaderOrigin:CGPoint = CGPointMake(CGFloat.infinity, CGFloat.infinity)
            if indexPath.section+1<self.collectionView?.numberOfSections() {
                let nextHeaderAttributes:UICollectionViewLayoutAttributes = super.layoutAttributesForSupplementaryViewOfKind(elementKind, atIndexPath: NSIndexPath(forRow: 0, inSection: indexPath.section+1))!
                nextHeaderOrigin = nextHeaderAttributes.frame.origin
            }
            var frame:CGRect = (attributes?.frame)!
            if self.scrollDirection != .Vertical {
                frame.origin.x = min(max(contentOffset.x, frame.origin.x), nextHeaderOrigin.x - CGRectGetWidth(frame))
            }
            attributes?.zIndex = -1
            attributes?.frame = frame
            
        }
        
        return attributes
    }
    
    override func initialLayoutAttributesForAppearingSupplementaryElementOfKind(elementKind: String, atIndexPath elementIndexPath: NSIndexPath) -> UICollectionViewLayoutAttributes? {
        return self.layoutAttributesForSupplementaryViewOfKind(elementKind, atIndexPath:elementIndexPath)
    }
    
    override func finalLayoutAttributesForDisappearingSupplementaryElementOfKind(elementKind: String, atIndexPath elementIndexPath: NSIndexPath) -> UICollectionViewLayoutAttributes? {
        return self.layoutAttributesForSupplementaryViewOfKind(elementKind, atIndexPath:elementIndexPath)
    }
}
