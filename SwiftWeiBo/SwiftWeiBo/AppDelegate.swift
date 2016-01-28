//
//  AppDelegate.swift
//  SwiftWeiBo
//
//  Created by 程倩 on 16/1/28.
//  Copyright © 2016年 CQ. All rights reserved.
//

import UIKit

@UIApplicationMain
class AppDelegate: UIResponder, UIApplicationDelegate {

    var window: UIWindow?


    func application(application: UIApplication, didFinishLaunchingWithOptions launchOptions: [NSObject: AnyObject]?) -> Bool {
        // Override point for customization after application launch.
        // 创建window
        window = UIWindow(frame: UIScreen.mainScreen().bounds)
        // 设置颜色
        window?.backgroundColor = UIColor.whiteColor()
        // 设置根控制器
        window?.rootViewController = MainTabBarViewController();
        window?.makeKeyAndVisible()
        
        return true
    }

    

}

