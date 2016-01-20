//
//  PopAnimator.swift
//  Expense
//
//  Created by Monica Ong on 1/20/16.
//  Copyright © 2016 Monica Ong. All rights reserved.
//

import UIKit

class PopAnimator: NSObject, UIViewControllerAnimatedTransitioning {
    
    
    let duration    = 0.3
    var presenting  = true
    var originFrame = CGRect.zero
    
    func transitionDuration(transitionContext: UIViewControllerContextTransitioning?)-> NSTimeInterval {
        return duration
    }
    
    func animateTransition(transitionContext: UIViewControllerContextTransitioning) {
        let containerView = transitionContext.containerView()!
        
        let toView =
        transitionContext.viewForKey(UITransitionContextToViewKey)!
        
        let herbView = presenting ? toView : transitionContext.viewForKey(UITransitionContextFromViewKey)!
        
        // calculate the scale factor you need to apply on each axis as you animate between each view
        let initialFrame = presenting ? originFrame : herbView.frame
        let finalFrame = presenting ? herbView.frame : originFrame
        
        let xScaleFactor = presenting ?
            initialFrame.width / finalFrame.width :
            finalFrame.width / initialFrame.width
        
        let yScaleFactor = presenting ?
            initialFrame.height / finalFrame.height :
            finalFrame.height / initialFrame.height
        
        //When presenting the new view, you set its scale and position so it exactly matches the size and location of the initial frame
        let scaleTransform = CGAffineTransformMakeScale(xScaleFactor, yScaleFactor)
        
        if presenting {
            herbView.transform = scaleTransform
            herbView.center = CGPoint(
                x: CGRectGetMidX(initialFrame),
                y: CGRectGetMidY(initialFrame))
            herbView.clipsToBounds = true
        }
        
        containerView.addSubview(toView)
        containerView.bringSubviewToFront(herbView)
        
        UIView.animateWithDuration(duration, animations: {
            herbView.transform = self.presenting ?
                CGAffineTransformIdentity : scaleTransform
            
            herbView.center = CGPoint(x: CGRectGetMidX(finalFrame),
                y: CGRectGetMidY(finalFrame))
            }, completion: {_ in
                transitionContext.completeTransition(true)
        })
        //        UIView.animateWithDuration(duration, delay: 0.0, options: .CurveEaseInOut, animations: {            herbView.transform = self.presenting ?
        //                CGAffineTransformIdentity : scaleTransform
        //
        //            herbView.center = CGPoint(x: CGRectGetMidX(finalFrame),
        //                y: CGRectGetMidY(finalFrame))
        //            }, completion: {_ in
        //                transitionContext.completeTransition(true)
        //        })
        
        //        UIView.animateWithDuration(duration, delay:0.0,
        //            usingSpringWithDamping: 0.0,
        //            initialSpringVelocity: 0.0,
        //            options: [],
        //            animations: {
        //                herbView.transform = self.presenting ?
        //                    CGAffineTransformIdentity : scaleTransform
        //
        //                herbView.center = CGPoint(x: CGRectGetMidX(finalFrame),
        //                    y: CGRectGetMidY(finalFrame))
        //                
        //            }, completion:{_ in
        //                transitionContext.completeTransition(true)
        //        })
    }
}

