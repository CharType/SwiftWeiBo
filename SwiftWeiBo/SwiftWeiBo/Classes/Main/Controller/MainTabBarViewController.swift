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
        
        // 添加控制器
        addChildViewControllers()
        
    }
    override func viewDidAppear(animated: Bool) {
        super.viewDidAppear(animated)
        //添加加号按钮
        setupComposeBtn();
    }
    
    /**
     *加号按钮的点击事件方法，不能声明成private,因为是runloop调用的
     */
    func buttonClick(){
      print("点击了+号按钮")
    }
    /**
     *设置加号按钮的位置
     */
    private func setupComposeBtn(){
        // 添加按钮
     tabBar.addSubview(composeBtn)
    //计算item的平均宽度
    let width = tabBar.bounds.width/CGFloat(viewControllers!.count)
        
    //创建按钮的fream
    let rect = CGRect(x: 0, y: 0, width: width, height: tabBar.bounds.height)
    //设置加号按钮的fream
    composeBtn.frame = CGRectOffset(rect, width*2, 0)
        
        
    }
    
    /**
     * 添加控制器
     */
    func addChildViewControllers(){
       
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
    
    //懒加载一个button
    private lazy var composeBtn : UIButton = {
        let button = UIButton();
        button.setImage(UIImage(named: "tabbar_compose_icon_add"), forState: UIControlState.Normal)
        button.setImage(UIImage(named: "tabbar_compose_icon_add_highlighted"), forState: UIControlState.Highlighted)
        
        button.setBackgroundImage(UIImage(named: "tabbar_compose_button"), forState: UIControlState.Normal)
        button.setBackgroundImage(UIImage(named: "tabbar_compose_button_highlighted"), forState: UIControlState.Highlighted)
        
        button.addTarget(self, action: "buttonClick", forControlEvents: UIControlEvents.TouchUpInside)
        return button;
        
    }()
}
