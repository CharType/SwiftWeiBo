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
  
    /// 用于调用access_token，接口获取授权后的access token。
    var access_token : String?
    /// access_token的生命周期，单位是秒数。
    var expires_in : NSNumber?{
        didSet{
           expires_Date = NSDate(timeIntervalSinceNow: expires_in!.doubleValue)
        }
    }
    
    /// 保存用户过期时间
    var expires_Date: NSDate?
    /// 当前授权用户的UID。
    var uid:String?
    
    override init() {
        
    }
    
    init(dict:[String:AnyObject]){
 
        super.init()
        //调用kvc的方法必须要先调用  super.init()
        setValuesForKeysWithDictionary(dict)
        
        
    }
    
    // kvc为了使kvc不崩溃 重写setValueforUndefinedKey
    override func setValue(value: AnyObject?, forUndefinedKey key: String) {
        print(key)
    }
    
    // MARK: - 返回用户是否登录
    class func userlogin() -> Bool {
        return UserAccount.loadAccount() != nil
    }
    
    static let filepath = "Acount.plist".cacheDir()
    // MARK: - 保存授权模型
    func saveAccount(){
    
        NSKeyedArchiver.archiveRootObject(self, toFile: UserAccount.filepath)
    }
    
    
 
    

    // MARK: - 加载授权模型
    static var account:UserAccount?
    class func loadAccount() ->UserAccount? {
      //1.判断是否已经加载过
        if account != nil {
           return account
        }
        
        // 加载授权模型
        account =  NSKeyedUnarchiver.unarchiveObjectWithFile(filepath) as? UserAccount
        
        // 判断授权信息是否过期
        if account?.expires_Date?.compare(NSDate()) == NSComparisonResult.OrderedAscending
        {
            // 已经过期
           return nil
        }
        return account
    }
    
    
    
     // MARK: - 打印对象数据调用方法  Swift2.0 打印对象需要重写CustomStringConvertible协议中的description
    override var description:String{
        
        // 定义属性数组
        let properties = ["access_token","expires_in","uid","expires_Date"]
        // 将属性数组转换为字典，接收key
        let dict =  self.dictionaryWithValuesForKeys(properties)
        
      return "\(dict)"
    }
    
    // MARK: - NSCoding协议方法
    func encodeWithCoder(aCoder: NSCoder){
    
      aCoder.encodeObject(access_token, forKey: "access_token")
      aCoder.encodeObject(expires_in, forKey: "expires_in")
      aCoder.encodeObject(uid, forKey: "uid")
      aCoder.encodeObject(expires_Date, forKey: "expires_Date")
        
    }
    required init?(coder aDecoder: NSCoder){
     
        access_token =  aDecoder.decodeObjectForKey("access_token") as? String
        expires_in = aDecoder.decodeObjectForKey("expires_in") as? NSNumber
        uid = aDecoder.decodeObjectForKey("uid") as? String
        expires_Date = aDecoder.decodeObjectForKey("expires_Date") as? NSDate
    
    }
}
