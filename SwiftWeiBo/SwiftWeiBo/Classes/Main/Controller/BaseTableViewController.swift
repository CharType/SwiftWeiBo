//
//  BaseTableViewController.swift
//  SwiftWeiBo
//
//  Created by 程倩 on 16/1/29.
//  Copyright © 2016年 CQ. All rights reserved.
//

import UIKit

class BaseTableViewController: UITableViewController {
    
    /// 定义变量保存时候登录
    var login:Bool = false;
    var visitorview :VisitorView?
    override func loadView() {
        // 如果已经登录，创建tableview 否则创建访客视图
        login ? super.loadView():setupVisitor()
    }
    
    private func setupVisitor(){
        visitorview = VisitorView();
        view = visitorview
    }
}
