//
//  CHTransitionLayout.swift
//  PaperInSwift
//
//  Created by HX_Wang on 15/10/10.
//  Copyright © 2015年 Team_ChineseHamburger. All rights reserved.
//

let kOffsetH = "offsetH"
let kOffsetV = "offsetV"

import UIKit

public class CHTransitionLayout : UICollectionViewTransitionLayout {
    public var progress : CGFloat?
    public var itemSize : CGSize?
    
    public var offset : UIOffset? {
        set {
            updateValue((newValue!.horizontal), forAnimatedKey:kOffsetH)
            updateValue((newValue!.vertical), forAnimatedKey:kOffsetV)
            self.offset = newValue
        }
        get {
            return self.offset
        }
        
    }
    
    override public var transitionProgress : CGFloat {
        didSet {
            super.transitionProgress = transitionProgress
            let offSetH = self.valueForAnimatedKey(kOffsetH)
            let offsetV = self.valueForAnimatedKey(kOffsetV)
            offset = UIOffsetMake(offSetH, offsetV)
        }
    }
    
//Compile Error
    override public func layoutAttributesForElementsInRect(rect: CGRect) -> [UICollectionViewLayoutAttributes]? {
        let attributes = super.layoutAttributesForElementsInRect(rect)
        for attribute in attributes! {
            if let currentAttribute = attribute as? UICollectionViewLayoutAttributes {
                if currentAttribute.representedElementCategory != .SupplementaryView {
                    let currentCenter = currentAttribute.center
                    let updatedCenter = CGPointMake(currentCenter.x, currentCenter.y)
                    currentAttribute.center = updatedCenter
                }else {
                    currentAttribute.frame = (self.collectionView?.bounds)!
                }
            }
        }
        return attributes
    }
    
    override public func layoutAttributesForItemAtIndexPath(indexPath: NSIndexPath) -> UICollectionViewLayoutAttributes? {
        let attributes = super.layoutAttributesForItemAtIndexPath(indexPath)
        let currentCenter = attributes?.center
        let updatedCenter = CGPointMake((currentCenter?.x)! + (offset?.horizontal)!, (currentCenter?.y)! + (offset?.vertical)!)
        attributes?.center = updatedCenter
        return attributes
    }
}
