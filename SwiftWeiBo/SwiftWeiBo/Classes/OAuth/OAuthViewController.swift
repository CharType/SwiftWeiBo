//
//  OAuthViewController.swift
//  SwiftWeiBo  加载OAtuh登录页面
//
//  Created by 程倩 on 16/2/14.
//  Copyright © 2016年 CQ. All rights reserved.
//

import UIKit

class OAuthViewController: UIViewController {

    let Wb_App_Key = "4141739840"
    let Wb_App_Secret = "7f5f2de76d2871fc94a935dcfdc9a829"
    let Wb_redirect_uri = "http://ashaj.com/yyywebpage/index.html"
    override func loadView() {
        // 将当前view更换为webview
        view = webview
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        // 0.初始化导航控制器
        navigationItem.title = "登录"
        navigationItem.rightBarButtonItem = UIBarButtonItem(title: "关闭", style: UIBarButtonItemStyle.Plain, target: self, action: "close")
        // 1.获取未授权的Requersttoken
       let urlStr = "https://api.weibo.com/oauth2/authorize?client_id=\(Wb_App_Key)&redirect_uri=\(Wb_redirect_uri)"
        let url = NSURL(string: urlStr)
        let request = NSURLRequest(URL: url!)
        webview.loadRequest(request)

    }

   
    
    func close(){
       dismissViewControllerAnimated(true, completion: nil)
    }
    
    // MARK: - 懒加载webView
    private lazy var webview :UIWebView = {
       let webview = UIWebView()
        webview.delegate = self
        return webview
    }()

}

extension OAuthViewController : UIWebViewDelegate{

     func webView(webView: UIWebView, shouldStartLoadWithRequest request: NSURLRequest, navigationType: UIWebViewNavigationType) -> Bool{
        
        print(request.URL!.absoluteString)
        
        // 1.判断是否是授权回调页面，如果不是就继续加载
        let url = request.URL!.absoluteString
        if !url.hasPrefix(Wb_redirect_uri){
           return true
        }
        // 2.如果是授权回调页面，判断授权成功或者失败
        let codestr = "code="
        // query  取到url后面的所有的参数
        if ((request.URL!.query?.hasPrefix(codestr)) != nil){
             print("授权成功")
            // 1.取出已经授权的RequestToken
            let code = request.URL!.query?.substringFromIndex(codestr.endIndex)
     
            // 2.换取AccessToken
            loadAccessToken(code!)
        
        }else{
            print("取消授权")
            close()// 关闭当前界面
        }
        
      return false
    }
    /**
     换取AccessToken
     
     - parameter code: 已经收授权的requesttoken
     */
    private func loadAccessToken(code:String){
        
        // 1.定义路径
        let path = "oauth2/access_token"
        
        // 2.封装参数
        let parame = ["client_id":Wb_App_Key,"client_secret":Wb_App_Secret,"grant_type":"authorization_code","code":code,"redirect_uri":Wb_redirect_uri]
        
       NetworkTools.shareNetworkTools().POST(path, parameters: parame, success: { (_, JSON) -> Void in
          print(JSON)
        }) { (_, error) -> Void in
          print(error)
        }
    }
    
}
