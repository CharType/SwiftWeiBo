//
//  MainTabBarViewController.swift
//  SwiftWeiBo
//
//  Created by 程倩 on 16/1/28.
//  Copyright © 2016年 CQ. All rights reserved.
//

import UIKit

class MainTabBarViewController: UITabBarController {

    override func viewDidLoad() {

        
        tabBar.tintColor = UIColor.orangeColor()
        
        
        // 添加子控制器
        addChildViewController(HomeTableViewController(), title:"首页", imageName: "tabbar_home")
        addChildViewController(MessageTableViewController(), title: "消息", imageName: "tabbar_message_center")
        addChildViewController(DisCoverTableViewController(), title: "发现", imageName: "tabbar_discover")
        addChildViewController(ProfileTableViewController(), title: "我", imageName: "tabbar_profile")
        
        
    }
    
    private func addChildViewController(childController: UIViewController,title:String,imageName:String) {
        
        // 设置childController的一些属性
        childController.tabBarItem.image = UIImage(named: imageName)
        childController.tabBarItem.selectedImage = UIImage(named: imageName + "_highlighted")
        childController.title = title
        
        // 创建导航控制器
        let nav = UINavigationController()
        // 将当前控制器包装一个导航控制器
        nav.addChildViewController(childController)
        
        // 将导航控制器添加到当前的子控制器上
        addChildViewController(nav)
    }
    
    
}
