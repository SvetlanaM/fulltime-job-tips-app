//
//  UINavigationController+RadialTransaction.swift
//  AAPRadialTransaction_swift
//
//  Created by Alex Padalko on 9/23/14.
//  Copyright (c) 2014 Alex Padalko. All rights reserved.
//

import UIKit
let abc=AAPTransactionDirector();

var defaultRadialDuration:CGFloat = 0.5

extension UINavigationController {

  
    
    
    func getLeftRect()->CGRect{
        
        return CGRectZero
        
    }
//MARK: PUSH
    /**
    * radial pushing view controller
    *
    * @param startFrame where circle start
    */
    func radialPushViewController(viewController: UIViewController, duration: CGFloat = 0.33 ,startFrame:CGRect = CGRectNull, transitionCompletion: (() -> Void)? = nil ){
        
        var rect = startFrame
        if(rect == CGRectNull){
            
            rect = CGRectMake(self.visibleViewController!.view.frame.size.width, self.visibleViewController!.view.frame.size.height/2, 0, 0)
        }
        
      
       var animatorDirector:AAPTransactionDirector?=AAPTransactionDirector();
        animatorDirector?.duration=duration
        
    
        self.delegate=animatorDirector;
        animatorDirector?.animationBlock={(transactionContext:UIViewControllerContextTransitioning, animationTime: CGFloat ,completion:()->Void)->Void in
 
            let toViewController = transactionContext.viewControllerForKey(UITransitionContextToViewControllerKey)
            let fromViewController = transactionContext.viewControllerForKey(UITransitionContextFromViewControllerKey)
            let containerView = transactionContext.containerView()
            
            containerView!.insertSubview(toViewController!.view, aboveSubview: fromViewController!.view)

            toViewController?.view .radialAppireanceWithStartFrame(rect, duration: animationTime, complitBlock: { () -> Void in
                
                
                completion();
                
                transitionCompletion?();
           
              
           })

        }
          self.pushViewController(viewController, animated: true)

        
        
          self.delegate = nil;
      
    }
//MARK: POP
    /**
    * radial pop view controller
    *
    * @param startFrame where circle start
    */
    func radialPopViewController( duration: CGFloat = 0.33 ,startFrame:CGRect = CGRectNull, transitionCompletion: (() -> Void)? = nil ){
        
        var rect = startFrame
        if(rect == CGRectNull){
            
            rect = CGRectMake(0, self.visibleViewController!.view.frame.size.height/2, 0, 0)
        }
        
        
        var animatorDirector=AAPTransactionDirector();
        animatorDirector.duration=duration
        self.delegate=animatorDirector;
        animatorDirector.animationBlock={(transactionContext:UIViewControllerContextTransitioning, animationTime: CGFloat ,completion:()->Void)->Void in
            
            let toViewController = transactionContext.viewControllerForKey(UITransitionContextToViewControllerKey)
            let fromViewController = transactionContext.viewControllerForKey(UITransitionContextFromViewControllerKey)
            let containerView = transactionContext.containerView()
            
            containerView!.insertSubview(toViewController!.view, aboveSubview: fromViewController!.view)
            
            toViewController?.view .radialAppireanceWithStartFrame(rect, duration: animationTime, complitBlock: { () -> Void in
                completion();
             transitionCompletion?();
                
                
            })
            
        }
        
        self.popViewControllerAnimated(true)
            self.delegate = nil;
    }
    
    
    //MARK: Swipe
    
    func enableRadialSwipe(){
        
  
        
        
   self.enableGesture(true)
        
        
        
    }
    func disableRadialSwipe(){
self.enableGesture(false)
        
    }
    
    /**
    * enabling swipe back gesture. NOTE interactivePopGestureRecognizer will be disabled
    *
    */
    private func enableGesture(enabled:Bool){
        
        struct StaticStruct {
        
            static var recognizerData = Dictionary<String,UIGestureRecognizer>()
            
        }
        
        if enabled == true {
            
            if self.respondsToSelector(Selector("interactivePopGestureRecognizer")) {
                
                self.interactivePopGestureRecognizer!.enabled = false
            }
            
            let  panGesture = UIScreenEdgePanGestureRecognizer(target: self, action: Selector("screenPan:"))
            panGesture.edges = UIRectEdge.Left
            
            self.view.addGestureRecognizer(panGesture)
            
            StaticStruct.recognizerData[self.description] = panGesture
            
            
            
        }else {
            
            self.view.removeGestureRecognizer(StaticStruct.recognizerData[self.description]!)
            StaticStruct.recognizerData[self.description] = nil
            
        }
    }
    

}






