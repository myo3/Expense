//
//  RiseAnimator.swift
//  Expense
//
//  Created by Monica Ong on 1/21/16.
//  Copyright © 2016 Monica Ong. All rights reserved.
//

import UIKit

class RiseAnimator: NSObject, UIViewControllerAnimatedTransitioning {
    
    
    let duration = 0.3
    var presenting  = true
    var backgroundTintColor: UIColor?
    
    func transitionDuration(transitionContext: UIViewControllerContextTransitioning?)-> NSTimeInterval {
        return duration
    }
    
    func animateTransition(transitionContext: UIViewControllerContextTransitioning) {
        /* Get...
        * the view controller navigating from,
        * the view controller navigating to,
        * the final frame the transition context should have after the animation completes
        * the container view which houses the views corresponding to the to and from view controllers
        */
        let containerView = transitionContext.containerView()!
        let mainScreenFrame = UIScreen.mainScreen().bounds
        let fromViewController = transitionContext.viewControllerForKey(UITransitionContextFromViewControllerKey)!
        let toViewController = transitionContext.viewControllerForKey(UITransitionContextToViewControllerKey)!
        let dateView = presenting ? toViewController.view : transitionContext.viewForKey(UITransitionContextFromViewKey)
        let finalFrameforDateVC = presenting ? transitionContext.finalFrameForViewController(toViewController): CGRectOffset(transitionContext.finalFrameForViewController(fromViewController), 0, mainScreenFrame.size.height)
        
        if presenting{
            //position the to view just below the bottom of the screen
            toViewController.view.frame = CGRectOffset(finalFrameforDateVC, 0, mainScreenFrame.size.height)
        }
        
        //Overylay background tint
        let backgroundTint = UIView(frame: mainScreenFrame)
        backgroundTint.backgroundColor = backgroundTintColor
        backgroundTint.alpha = presenting ? 0 : 0.8
        
        //add the to view to the container view
        containerView.addSubview(toViewController.view)
        containerView.addSubview(backgroundTint)
        containerView.bringSubviewToFront(dateView)
        
        /* In the animation closure...
        * animate the to view by setting its final frame to the location given by the transition context
        * animate the from view‘s alpha value so that as the to view is sliding up the screen over the from view, the from view will be faded out
        * the duration of the animation used is the one set in transitionDuration(transitionContext:)
        */
        /* In the completion closure...
        * notify the transition context when the animation completes and then change the from view‘s alpha back to normal. The framework will then remove the from view from the container.
        */
        UIView.animateWithDuration(duration, animations: {
            backgroundTint.alpha = self.presenting ? 0.8 : 0
            dateView.frame = finalFrameforDateVC
            }) { finished in transitionContext.completeTransition(true)
        }
//        UIView.animateWithDuration(transitionDuration(transitionContext), delay: 0.0, usingSpringWithDamping: 0.5, initialSpringVelocity: 0.0, options: .CurveLinear, animations: {
//            fromViewController.view.alpha = 0.5
//            toViewController.view.frame = finalFrameForVC
//            }, completion: {
//                finished in
//                transitionContext.completeTransition(true)
//                fromViewController.view.alpha = 1.0
//        })
    }
}
