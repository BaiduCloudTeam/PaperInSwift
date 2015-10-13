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
    private weak var context : UIViewControllerContextTransitioning?
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
        context = transitionContext;
        
        let fromCollectionViewController = transitionContext.viewControllerForKey(UITransitionContextFromViewControllerKey) as? UICollectionViewController
    
        let toCollectionViewController = transitionContext.viewControllerForKey(UITransitionContextToViewControllerKey) as? UICollectionViewController
        
        let containerView = transitionContext.containerView()
        containerView?.addSubview((toCollectionViewController?.view)!)
        
        fromCollectionViewController?.collectionView?.startInteractiveTransitionToCollectionViewLayout((toCollectionViewController?.collectionViewLayout)!, completion: {didFinish,didComplete in
            self.context?.completeTransition(didComplete)
            self.transitionLayout = nil
            self.context = nil
            self.hasActiveInteraction = false
        })
    }
    
    func updateWithProgress(progress:CGFloat, andOffset offset:UIOffset) {
        if let _ = self.context {
            if (((progress != self.transitionLayout!.transitionProgress) || !UIOffsetEqualToOffset(offset, self.transitionLayout!.offset!))) {
                self.transitionLayout?.offset = offset
                self.transitionLayout?.transitionProgress = progress
                self.transitionLayout?.invalidateLayout()
                self.context?.updateInteractiveTransition(progress)
            }
           
        }
    }
    
    func updateWithProgress(progress:CGFloat) {
        if let _ = self.context {
            if(((progress != self.transitionLayout!.transitionProgress))) {
                self.transitionLayout?.transitionProgress = progress
                self.transitionLayout?.invalidateLayout()
                self.context?.updateInteractiveTransition(progress)
            }
            
        }
    }
    
    func endInteractionWithSuccess(success:Bool) {
        guard let _ = self.context else {
            self.hasActiveInteraction = false;
            return
        }
        if ((self.transitionLayout!.transitionProgress > 0.1) && success) {
            self.collectionView.finishInteractiveTransition()
            self.context?.finishInteractiveTransition()
        } else {
            self.collectionView.cancelInteractiveTransition()
            self.context?.cancelInteractiveTransition()
        }
    }
    // MARK: - CHControllerTransitionDelegate Method
    func interactionBeganAtPoint(origin : CGPoint) {
        
    }
    
    func handlePinch(sender : UIPinchGestureRecognizer) {
        if (sender.state == UIGestureRecognizerState.Ended) {
            self.endInteractionWithSuccess(true)
        } else if (sender.state ==  UIGestureRecognizerState.Cancelled) {
            self.endInteractionWithSuccess(false)
        } else if (sender.numberOfTouches() == 2) {
            var point:CGPoint = CGPointZero
            var point1:CGPoint = CGPointZero
            var point2:CGPoint = CGPointZero
            var distance:CGFloat = 0
            
            point1 = sender.locationOfTouch(0, inView: sender
            .view)
            point2 = sender.locationOfTouch(1, inView: sender
            .view)
            distance = sqrt((point1.x - point2.x) * (point1.x - point2.x) + (point1.y - point2.y) * (point1.y - point2.y))
        
            point = sender.locationInView(sender.view)
            if(sender.state == UIGestureRecognizerState.Began) {
                if(!self.hasActiveInteraction) {
                    self.initialPinchDistance = distance
                    self.initialPinchPoint = point
                    self.hasActiveInteraction = true
                    self.delegate?.interactionBeganAtPoint(point)
                }
            }
            if(self.hasActiveInteraction) {
                if(sender.state == UIGestureRecognizerState.Changed) {
                    let delta :CGFloat = distance - self.initialPinchDistance!
                    let offsetX :CGFloat = point.x - (self.initialPinchPoint?.x)!
                    let offsetY:CGFloat  = (point.y - self.initialPinchPoint!.y) + delta/CGFloat(M_PI);
                    let offsetToUse:UIOffset = UIOffsetMake(offsetX, offsetY)
                    var distanceDelta:CGFloat = distance - self.initialPinchDistance!
                    if (self.navigationOperation == UINavigationControllerOperation.Pop) {
                        distanceDelta = -distanceDelta
                    }
                    let progress:CGFloat = max(min(((distanceDelta + sender.velocity * CGFloat(M_PI)) / 250), 1.0), 0.0)
                    self.updateWithProgress(progress, andOffset: offsetToUse)
                }
            }
        
        }
        
    }
    
    public func gestureRecognizer(gestureRecognizer: UIGestureRecognizer, shouldRecognizeSimultaneouslyWithGestureRecognizer otherGestureRecognizer: UIGestureRecognizer) -> Bool {
        return true
    }
    
}

