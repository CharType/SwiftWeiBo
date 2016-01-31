//
//  UIBarButtonItem+Category.swift
//  SwiftWeiBo
//
//  Created by 程倩 on 16/1/31.
//  Copyright © 2016年 CQ. All rights reserved.
//

import UIKit

extension UIBarButtonItem
{
    // 给UIBarButtonItem添加一个类方法
    class func  crateBarButtonItem(imageName:String,target:AnyObject?,action:Selector) -> UIBarButtonItem{
    
        let button = UIButton()
        button.frame = CGRect(x: 0, y: 0, width: 30, height: 30)
        button.setImage(UIImage(named: imageName), forState: UIControlState.Normal)
        button.setImage(UIImage(named: imageName + "_highlighted"), forState: UIControlState.Highlighted)
        button.addTarget(target, action: action, forControlEvents: UIControlEvents.TouchUpInside)
        return UIBarButtonItem(customView: button)
    }
}


