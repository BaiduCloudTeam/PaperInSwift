//
//  CHTransitionViewController.swift
//  PaperInSwift
//
//  Created by HX_Wang on 15/10/10.
//  Copyright © 2015年 Team_ChineseHamburger. All rights reserved.
//

import UIKit

public protocol CHControllerTransitionDelegate : class {
    func interactionBeganAtPoint(origin : CGPoint);
}

public class CHTranstionController: NSObject, UIViewControllerAnimatedTransitioning,UIViewControllerInteractiveTransitioning, UIGestureRecognizerDelegate {
    
    // MARK: - Public Properties
    public var delegate : CHControllerTransitionDelegate?
    public var hasActiveInteraction : Bool = false
    public var navigationOperation : UINavigationControllerOperation?
    public var collectionView : UICollectionView!
    
    // MARK: - Private Properties
    private var transitionLayout : CHTransitionLayout?
    private var initialPinchDistance : CGFloat?
    private var initialPinchPoint : CGPoint?
    private var initialScale : CGFloat?
    
    // MARK: - Initializer
    public init(collectionView : UICollectionView) {
        super.init()
        let pinchGesture = UIPinchGestureRecognizer(target: self, action: Selector("handlePinch:"))
        collectionView.addGestureRecognizer(pinchGesture)
        
    }
    
    // MARK: - UIViewControllerAnimatedTransitioning Delegate Method
    public func transitionDuration(transitionContext: UIViewControllerContextTransitioning?) -> NSTimeInterval {
        return NSTimeInterval(1)
    }
    // This method can only  be a nop if the transition is interactive and not a percentDriven interactive transition.
    public func animateTransition(transitionContext: UIViewControllerContextTransitioning) {
        
    }
    
    // MARK: - UIViewControllerInteractiveTransitioning Delegate Method
    public func startInteractiveTransition(transitionContext: UIViewControllerContextTransitioning) {
        
    }
    
    // MARK: - CHControllerTransitionDelegate Method
    func interactionBeganAtPoint(origin : CGPoint) {
        
    }
    
    func handlePinch(pinchGesture : UIPinchGestureRecognizer) {
        
    }
    
}

