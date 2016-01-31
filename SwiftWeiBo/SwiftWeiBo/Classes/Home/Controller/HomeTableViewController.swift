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
      btn.selected = !btn.selected
    }
    
    // MARK: - 左右item的绑定事件
    func letBtnClick(){
      print(__FUNCTION__)
    }
    func rightBtnClick(){
     print(__FUNCTION__)
    }
}
