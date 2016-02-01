//
//  PopoverPresentationController.swift
//  SwiftWeiBo
//
//  Created by 程倩 on 16/1/31.
//  Copyright © 2016年 CQ. All rights reserved.
//用来创建转场动画的对象

import UIKit

@available(iOS 8.0, *)
class PopoverPresentationController: UIPresentationController {
  
    // 定义属性用来保存菜单的大小
    var presentFrame = CGRectZero
    
    /**
     初始化方法，用于负责转场动画对象
     
     - parameter presentedViewController:  被展现的控制器
     - parameter presentingViewController: 发起的控制器，Xcode6是nil,Xcode7是野指针
     
     - returns: 负责转场动画的对象
     */
    override init(presentedViewController: UIViewController, presentingViewController: UIViewController) {
        super.init(presentedViewController: presentedViewController, presentingViewController: presentingViewController)
    }
    
    /**
     即将布局转场子视图时调用
     */
    override func containerViewWillLayoutSubviews()
    {
        // 1.修改弹出视图的大小
        if presentFrame == CGRectZero{
            
            presentedView()?.frame = CGRect(x: 100, y: 56, width: 200, height: 200)
        }else
        {
            presentedView()?.frame = presentFrame
        }
        
        // 2.在容器视图上添加一个蒙版, 插入到展现视图的下面
        containerView?.insertSubview(coverView, atIndex: 0)
    }
    
    // MARK: - 懒加载
    private lazy var coverView: UIView = {
        // 1.创建view
        let view = UIView()
        view.backgroundColor = UIColor(white: 0.0, alpha: 0.2)
        view.frame = UIScreen.mainScreen().bounds
        
        // 2.添加监听
        let tap = UITapGestureRecognizer(target: self, action: "close")
        view.addGestureRecognizer(tap)
        return view
    }()
    
    func close(){
        // presentedViewController拿到当前弹出的控制器
        presentedViewController.dismissViewControllerAnimated(true, completion: nil)
    }
}
