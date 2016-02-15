//
//  UserAccount.swift
//  SwiftWeiBo
//
//  Created by 程倩 on 16/2/15.
//  Copyright © 2016年 CQ. All rights reserved.
// 保存用户登录后的AccessToken

import UIKit


// Swift2.0 打印对象需要重写CustomStringConvertible协议中的description
class UserAccount: NSObject {
  
    var access_token : String?
    
    var expires_in : NSNumber?
    
    var uid:String?
    
    override init() {
        
    }
    
    init(dict:[String:AnyObject]){
        //从字典中取出的不一定是String 类型  需要做一步转换
     access_token = dict["access_token"] as? String
     expires_in = dict["expires_in"]  as? NSNumber
     uid = dict["uid"]  as? String
        
        
    }
    
    override var description:String{
        
        // 定义属性数组
        let properties = ["access_token","expires_in","uid"]
        // 将属性数组转换为字典，接收key
        let dict =  self.dictionaryWithValuesForKeys(properties)
        
      return "\(dict)"
    }
}
