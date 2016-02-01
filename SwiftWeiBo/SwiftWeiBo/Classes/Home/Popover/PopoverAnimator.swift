//
//  PopoverAnimator.swift
//  SwiftWeiBo
//
//  Created by 程倩 on 16/1/31.
//  Copyright © 2016年 CQ. All rights reserved.
//

import UIKit

let CQPopoverAnimatorWillShow = "CQPopoverAnimatorWillShow"
let CQPopoverAnimatorWillDismiss = "CQPopoverAnimatorWillDismiss"
class PopoverAnimator: NSObject,UIViewControllerTransitioningDelegate,UIViewControllerAnimatedTransitioning{
  
    // 记录当前是否展开
    var isPresent:Bool = false
    // 记录保存菜单属性的大小
    var presentFrame = CGRectZero
    
    /**
     *实现代理方法 告诉系统 谁来负责转场动画
     */
    func presentationControllerForPresentedViewController(presented: UIViewController, presentingViewController presenting: UIViewController, sourceViewController source: UIViewController) -> UIPresentationController? {
        
        let pc = PopoverPresentationController(presentedViewController: presented, presentingViewController: presenting)
        
        pc.presentFrame = presentFrame
        
        return pc
        
    }
    
    // MARK: - 实现了下面这个方法，那么系统自带的默认动画就没有了，所有的东西都要自己来做
    
    /**
    告诉系统，谁来负责Modal的展现动画
    
    - parameter presented:  被展现的视图
    - parameter presenting: 发起的视图
    - parameter source:
    
    - returns: 谁来负责
    */
    func animationControllerForPresentedController(presented: UIViewController, presentingController presenting: UIViewController, sourceController source: UIViewController) -> UIViewControllerAnimatedTransitioning? {
        isPresent = true
        
        // 发送通知，通知控制器要展开
        NSNotificationCenter.defaultCenter().postNotificationName(CQPopoverAnimatorWillShow, object:self )
        
        return self
    }
    
    /**
     告诉控制器谁来负责Modal的消失动画
     
     - parameter dismissed: 被关闭的视图
     
     - returns: 谁来负责
     */
    func animationControllerForDismissedController(dismissed: UIViewController) -> UIViewControllerAnimatedTransitioning? {
        isPresent = false
        // 发送通知，通知控制器要消失
         NSNotificationCenter.defaultCenter().postNotificationName(CQPopoverAnimatorWillDismiss, object:self )
        return self
    }
    
    // MARK: - UIViewControllerAnimatedTransitioning
    /**
    f返回动画执行时间
    
    - parameter transitionContext: 上下文，里面保存了动画的所有参数
    
    - returns: 动画时长
    */
    func transitionDuration(transitionContext: UIViewControllerContextTransitioning?) -> NSTimeInterval {
        return 0.5
    }
    
    /**
     告诉系统如何动画，无论展现，还是消失，都会调用这个方法
     
     - parameter transitionContext: 上下文，里面保存了动画的所有参数

     */
    func animateTransition(transitionContext: UIViewControllerContextTransitioning) {
        
        if isPresent{
          //展开
            
            print("展开")
            let toView = transitionContext.viewForKey(UITransitionContextToViewKey)!
            toView.transform = CGAffineTransformMakeScale(1.0 , 0.0);
            
            //注意: 一定要将视图添加到容器上
            transitionContext.containerView()?.addSubview(toView)
            //设置锚点
            toView.layer.anchorPoint = CGPoint(x: 0.5, y: 0)
            //执行动画
            UIView.animateWithDuration(transitionDuration(transitionContext), animations: { () -> Void in
                
                // 清空transform
                toView.transform = CGAffineTransformIdentity

                }, completion: { (_) -> Void in
                 transitionContext.completeTransition(true)
            })
            
            
        }else{

            
            print("关闭")
            let fromView = transitionContext.viewForKey(UITransitionContextFromViewKey)
            
            UIView.animateWithDuration(transitionDuration(transitionContext), animations: { () -> Void in
                // 注意:由于CGFloat是不准确的, 所以如果写0.0会没有动画
                // 压扁
                fromView?.transform = CGAffineTransformMakeScale(1.0, 0.001)
                }, completion: { (_) -> Void in
                    // 如果不写, 可能导致一些未知错误
                    transitionContext.completeTransition(true)
            })
        }
    }
    
}
