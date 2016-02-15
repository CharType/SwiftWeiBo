//
//  NetworkTools.swift
//  SwiftWeiBo
//
//  Created by 程倩 on 16/2/15.
//  Copyright © 2016年 CQ. All rights reserved.
//

import UIKit
import AFNetworking

class NetworkTools: AFHTTPSessionManager {

    static let tool:NetworkTools = {
        // baseurl 每次请求都会带上baseurl
        let url = NSURL(string: "https://api.weibo.com/")
        
        let t = NetworkTools(baseURL: url)
        
        // 设置afn能够接收到的数据类型
        t.responseSerializer.acceptableContentTypes = NSSet(objects: "application/json", "text/json", "text/javascript", "text/plain") as? Set<String>
        
        return t
    }()
    
    // 获取单例对象的类方法
    class func shareNetworkTools()->NetworkTools{
       return tool
    }
}
