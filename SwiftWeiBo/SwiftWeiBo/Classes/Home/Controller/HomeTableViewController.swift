//
//  HomeTableViewController.swift
//  SwiftWeiBo
//
//  Created by 程倩 on 16/1/28.
//  Copyright © 2016年 CQ. All rights reserved.
//

import UIKit

class HomeTableViewController: BaseTableViewController {
    override func viewDidLoad() {
        super.viewDidLoad()
        // 如果没有登录，设置未登录界面的信息
        if !userlogin {
          visitorView?.setupVisitorInfo(true, imageName: "visitordiscover_feed_image_house", message: "关注一些人，回这里看看有什么惊喜")
            return
        }
       
        
        //添加左右按钮
        setupNavgationItem();
        
        //注册通知，监听菜单
        NSNotificationCenter.defaultCenter().addObserver(self, selector: "change", name: CQPopoverAnimatorWillShow, object: nil)
        NSNotificationCenter.defaultCenter().addObserver(self, selector: "change", name: CQPopoverAnimatorWillDismiss, object: nil)
        
    }
    
    // MARK: - 当控制器被销毁的时候调用,移除所有的通知
    deinit{
       NSNotificationCenter.defaultCenter().removeObserver(self)
    }
    
    // MARK: - 接收到通知后调用，修改标题按钮的状态
    func change(){
       let titlebutton = navigationItem.titleView as! TitleButton
        titlebutton.selected = !titlebutton.selected
    }
    // MARK: - 添加左右按钮
    private func setupNavgationItem(){
     navigationItem.leftBarButtonItem = UIBarButtonItem.crateBarButtonItem("navigationbar_friendattention", target: self, action: "letBtnClick")
     navigationItem.rightBarButtonItem = UIBarButtonItem.crateBarButtonItem("navigationbar_pop", target: self, action: "rightBtnClick")
        
        // 初始化标题按钮
        let titleButton = TitleButton()
        titleButton.setTitle("CharType ", forState: UIControlState.Normal)
        titleButton.addTarget(self, action: "titleBtnClick:", forControlEvents: UIControlEvents.TouchUpInside)
        navigationItem.titleView = titleButton
        
    }
    
    // MARK: - titlebutton点击事件
    func titleBtnClick(btn:TitleButton){
//        // 1.修改箭头的方向
//        btn.selected = !btn.selected
        // 2.弹出菜单
        let sb = UIStoryboard(name: "PopoverViewController", bundle: nil)
        let vc = sb.instantiateInitialViewController()
        
       // 设置转场代理 默认情况下modal会移除以前的view  替换成当前的view
       // 自定义 不会
        vc?.transitioningDelegate = popAnimator
        //设置转场样式
        vc?.modalPresentationStyle = UIModalPresentationStyle.Custom
        
        //
        presentViewController(vc!, animated: true, completion: nil)
    }
    
    // MARK: - 左右item的绑定事件
    func letBtnClick(){
      print(__FUNCTION__)
    }
    func rightBtnClick(){
     print(__FUNCTION__)
    }
    
    // MARK: - 懒加载转场动画控件
    
    private lazy var popAnimator:PopoverAnimator = {
      
        let pa = PopoverAnimator()
        pa.presentFrame = CGRect(x: 100, y: 56, width: 200, height: 350)
        return pa
    }()
}



