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
        
        // 1.获取json文件路径
         let path = NSBundle.mainBundle().pathForResource("MainVCSettings.json", ofType: nil)
        
        
        // 2.通过文件路径创建NSData
        
        if let jsonpath = path{
           let jsonData = NSData(contentsOfFile: jsonpath)
            
            do{
                // 将json转换成Array 
                // jsonData 是可选类型，必须强制拆包 这句代码容易发生异常，必须try
              let dictArr =  try NSJSONSerialization.JSONObjectWithData(jsonData!, options: NSJSONReadingOptions.MutableContainers)
                
                // 对数组进行遍历的时候必须指明数组的类型
                for var dict in dictArr as! [[String:String]]{
                    addChildViewController(dict["vcName"]!, title: dict["title"]!, imageName: dict["imageName"]!)
                }
            }catch{
            
             print(error)
                // 加载文件出现错误  通过代码添加子控制器
                addChildViewController("HomeTableViewController", title:"首页", imageName: "tabbar_home")
                addChildViewController("MessageTableViewController", title: "消息", imageName: "tabbar_message_center")
                addChildViewController("DisCoverTableViewController", title: "发现", imageName: "tabbar_discover")
                addChildViewController("ProfileTableViewController", title: "我", imageName: "tabbar_profile")
            }
        }
        
       
        
        
    }
    
    private func addChildViewController(className: String,title:String,imageName:String) {
        
        // 动态获取命名空间 
        let namespase = NSBundle.mainBundle().infoDictionary!["CFBundleExecutable"] as! String
        
        // 将字符串转换为类，类名需要加上默认的命名空间
        let cls :AnyClass? =  NSClassFromString(namespase + "." + className)
        // 将AnyClass  转换为指定的类型
        let child = cls as! UIViewController.Type
        // 创建对象
        let childController = child.init()
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
