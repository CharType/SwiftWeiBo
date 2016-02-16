//
//  String+Category.swift
//  SwiftWeiBo
//
//  Created by 程倩 on 16/2/16.
//  Copyright © 2016年 CQ. All rights reserved.
//

import UIKit

extension String{
   
    /**
     将当前字符串拼接到cache后面
     
     - returns: 拼接后的字符串
     */
    func cacheDir()->String{
    
        let path = NSSearchPathForDirectoriesInDomains(NSSearchPathDirectory.CachesDirectory, NSSearchPathDomainMask.UserDomainMask, true).last! as NSString
        
        return path.stringByAppendingPathComponent((self as NSString).lastPathComponent)
        
    }
    
    /**
     将当前字符串拼接到Document后面
     
     - returns: 拼接后的字符串
     */
    func docDir()->String{
      
        let path = NSSearchPathForDirectoriesInDomains(NSSearchPathDirectory.DocumentDirectory, NSSearchPathDomainMask.UserDomainMask, true).last! as NSString
        
        return path.stringByAppendingPathComponent((self as NSString).lastPathComponent)
    }
    
    /**
     将当前字符串拼接到tmp后面
     
     - returns: 拼接后的字符串
     */
    func tmpDir()->String{
    
        let path = NSTemporaryDirectory() as NSString
        
        return path.stringByAppendingPathComponent((self as NSString).lastPathComponent)
    }
}
