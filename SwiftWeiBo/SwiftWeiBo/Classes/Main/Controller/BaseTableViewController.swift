//
//  BaseTableViewController.swift
//  SwiftWeiBo
//
//  Created by 程倩 on 16/1/29.
//  Copyright © 2016年 CQ. All rights reserved.
//

import UIKit

class BaseTableViewController: UITableViewController ,VisitorViewDelegate{
    
    /// 定义变量保存时候登录
    var userlogin:Bool = false;
    var visitorView :VisitorView?
    override func loadView() {
        // 如果已经登录，创建tableview 否则创建访客视图
        userlogin ? super.loadView():setupVisitor()
    }
    
    private func setupVisitor(){
        visitorView = VisitorView();
        visitorView?.delegate = self
        view = visitorView
        
        navigationItem.leftBarButtonItem = UIBarButtonItem(title: "注册", style: UIBarButtonItemStyle.Plain, target: self, action: "visitorViewregister")
        navigationItem.rightBarButtonItem = UIBarButtonItem(title: "登录", style: UIBarButtonItemStyle.Plain, target: self, action: "visitorViewLogin")
    }
    
    
    //MARK: - VisitorViewDelegate
    //登录按钮代理方法
    func visitorViewLogin()
    {
      print("点击了登录按钮")
    }
    // 注册按钮代理方法
    func visitorViewregister()
    {
      print("点击了注册按钮")
    }
    
}
