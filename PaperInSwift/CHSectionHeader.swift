//
//  CHSectionHeader.swift
//  PaperInSwift
//
//  Created by HX_Wang on 15/10/12.
//  Copyright © 2015年 Team_ChineseHamburger. All rights reserved.
//

import UIKit


class CHSectionHeader : UICollectionViewCell, UIScrollViewDelegate  {
    @IBOutlet weak var reflectedImage: UIImageView!
    @IBOutlet weak var scrollView: UIScrollView!
    @IBOutlet weak var pageControl: UIPageControl!
    
    @IBOutlet var imageViews: [UIImageView]!
    
    @IBOutlet weak var titleLabel: UILabel!
    @IBOutlet weak var subTitleLabel: UILabel!
    @IBOutlet weak var logoLabel: UILabel!
    
    var didPageControllerChanged:(NSInteger) -> Void = {(arg : NSInteger) -> Void  in }
    
    override internal func awakeFromNib() {
        self.reflectedImage.image = self.imageViews[0].image
        self.reflectedImage.transform = CGAffineTransformMakeScale(1.0, -1.0)
        self.clipsToBounds = true
        self.layer.cornerRadius = 4
        // Gradient to top image
        for view in imageViews {
            if let imageView = view as? UIImageView {
                let gradientLayer = CAGradientLayer()
                gradientLayer.colors = [UIColor(red: 0, green: 0, blue: 0, alpha: 0.4).CGColor,UIColor(white: 0, alpha: 0).CGColor]
                gradientLayer.frame = imageView.bounds
                imageView.layer.insertSublayer(gradientLayer, atIndex: 0)
            }
        }
        // Gradient to reflected image
        let gradientReflected = CAGradientLayer()
        gradientReflected.frame = self.reflectedImage.bounds
        gradientReflected.colors = [UIColor(red: 0, green: 0, blue: 0, alpha: 1).CGColor,UIColor(white: 0, alpha: 0).CGColor]
        reflectedImage.layer.insertSublayer(gradientReflected, atIndex: 0)
        
        // Label Shadow
        logoLabel.clipsToBounds = false
        logoLabel.layer.shadowOffset = CGSizeMake(0, 0)
        logoLabel.layer.shadowColor = UIColor.blackColor().CGColor
        logoLabel.layer.shadowRadius = 1
        logoLabel.layer.shadowOpacity = 0.6
        
        // TitleLabel Shadow
        titleLabel.clipsToBounds = false
        titleLabel.layer.shadowOffset = CGSizeMake(0, 0)
        titleLabel.layer.shadowColor = UIColor.blackColor().CGColor
        titleLabel.layer.shadowRadius = 1.0
        titleLabel.layer.shadowOpacity = 0.6
        
        // SubTitleLabel Shadow
        subTitleLabel.clipsToBounds = false
        subTitleLabel.layer.shadowOffset = CGSizeMake(0, 0)
        subTitleLabel.layer.shadowColor = UIColor.blackColor().CGColor
        subTitleLabel.layer.shadowRadius = 1
        subTitleLabel.layer.shadowOpacity = 0.6
    }
    
    func scrollViewDidEndDecelerating(scrollView: UIScrollView) {
        let pageWidth = scrollView.frame.size.width
        let fractionPage = scrollView.contentOffset.x / pageWidth
        let newPage = lround(Double(fractionPage))
        if pageControl.currentPage != newPage {
            reflectedImage.image = imageViews[newPage].image
            pageControl.currentPage = newPage
            didPageControllerChanged(newPage)
        }
    }
    
}