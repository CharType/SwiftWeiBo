//
//  UserAccount.swift
//  SwiftWeiBo
//
//  Created by 程倩 on 16/2/15.
//  Copyright © 2016年 CQ. All rights reserved.
// 保存用户登录后的AccessToken

import UIKit


// Swift2.0 打印对象需要重写CustomStringConvertible协议中的description
class UserAccount: NSObject,NSCoding {
  
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
    
    // MARK: - 返回用户是否登录
    class func userlogin() -> Bool {
        return UserAccount.loadAccount() != nil
    }
    
    // MARK: - 保存授权模型
    func saveAccount(){
    
        NSKeyedArchiver.archiveRootObject(self, toFile: "Acount.plist".cacheDir())
    }
    
    
 
    

    // MARK: - 加载授权模型
    static var account:UserAccount?
    class func loadAccount() ->UserAccount? {
      //1.判断是否已经加载过
        if account != nil {
           return account
        }
        
        // 加载授权模型
        account =  NSKeyedUnarchiver.unarchiveObjectWithFile("Acount.plist".cacheDir()) as? UserAccount
        return account
    }
    
    
    
     // MARK: - 打印对象数据调用方法  Swift2.0 打印对象需要重写CustomStringConvertible协议中的description
    override var description:String{
        
        // 定义属性数组
        let properties = ["access_token","expires_in","uid"]
        // 将属性数组转换为字典，接收key
        let dict =  self.dictionaryWithValuesForKeys(properties)
        
      return "\(dict)"
    }
    
    // MARK: - NSCoding协议方法
    func encodeWithCoder(aCoder: NSCoder){
    
      aCoder.encodeObject(access_token, forKey: "access_token")
      aCoder.encodeObject(expires_in, forKey: "expires_in")
      aCoder.encodeObject(uid, forKey: "uid")
        
    }
    required init?(coder aDecoder: NSCoder){
     
        access_token =  aDecoder.decodeObjectForKey("access_token") as? String
        expires_in = aDecoder.decodeObjectForKey("expires_in") as? NSNumber
        uid = aDecoder.decodeObjectForKey("uid") as? String
    
    }
}
