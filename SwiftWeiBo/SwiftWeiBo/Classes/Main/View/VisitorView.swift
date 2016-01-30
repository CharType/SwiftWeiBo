//
//  VisitorView.swift
//  SwiftWeiBo
//
//  Created by 程倩 on 16/1/29.
//  Copyright © 2016年 CQ. All rights reserved.
//

import UIKit

// 在Swift中定义一个协议必须实现NSObjectProtocol基协议
protocol VisitorViewDelegate:NSObjectProtocol
{
    //登录按钮代理方法
   func visitorViewLogin()
    // 注册按钮代理方法
   func visitorViewregister();
}

class VisitorView: UIView {

    weak var delegate:VisitorViewDelegate?
    override init(frame: CGRect) {
        super.init(frame: frame)
        
        setUI()
    }
    /**
      设置访客视图信息
     
     - parameter isHome:    是否是首页
     - parameter imageName: 图片名称
     - parameter message:   显示文字
     */
    func setupVisitorInfo(isHome: Bool, imageName: String, message: String){
        iconView.hidden = !isHome
        messageLabel.text = message
        homeIconView.image = UIImage(named: imageName)
    
        if isHome{
          startAnimation()
        }
    }
    
    private func  setUI(){
       //添加控件
        addSubview(iconView)
        addSubview(maskIconView)
        addSubview(homeIconView)
        addSubview(messageLabel)
        addSubview(registerButton)
        addSubview(loginButton)
//        addSubview(attentionButton)
      //自动布局
        //布局背景图片
        iconView.cq_AlignInner(type: CQ_AlignType.Center, referView: self, size: nil)
        
        //布局遮罩图
        maskIconView.cq_Fill(self)
        
        //布局小房子
        homeIconView.cq_AlignInner(type: CQ_AlignType.Center, referView: self, size: nil)
        
        //布局label
        messageLabel.cq_AlignVertical(type: CQ_AlignType.BottomCenter, referView: iconView, size: nil)
        addConstraint(NSLayoutConstraint(item: messageLabel, attribute: NSLayoutAttribute.Width, relatedBy: NSLayoutRelation.Equal, toItem: nil, attribute: NSLayoutAttribute.NotAnAttribute, multiplier: 1.0, constant: 224))
        //布局注册按钮
        registerButton.cq_AlignVertical(type: CQ_AlignType.BottomLeft, referView: messageLabel, size: CGSize(width: 100, height: 35), offset: CGPoint(x: 0, y: 20))
        //布局登录按钮
        loginButton.cq_AlignVertical(type: CQ_AlignType.BottomRight, referView: messageLabel, size: CGSize(width: 100, height: 35), offset: CGPoint(x: 0, y: 20))
        attentionButton.cq_AlignVertical(type: CQ_AlignType.BottomCenter, referView: messageLabel, size:CGSize(width: 100, height: 35))
    }

    // 必须重写这个方法, Swift推荐我们要么支持纯代码, 要么支持XIB
    // 这样可以简化代码的复杂度
    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    // MARK: - 注册按钮监听事件
    func registerButtonClick(){
       delegate?.visitorViewregister()
    }
    
    // MARK: - 登录按钮监听事件
    func loginButtonClick(){
      delegate?.visitorViewLogin()
    }
    // MARK: - 首页动画
    private func startAnimation(){
      // 1.创建动画
        let animation = CABasicAnimation(keyPath: "transform.rotation")
      // 2.设置动画属性
        animation.toValue = 2 * M_PI
        animation.duration = 20
        //设置动画的执行时间
        animation.repeatCount = MAXFLOAT
        // 动画执行完毕后会默认的从图层删除掉
        animation.removedOnCompletion = false
        
        iconView.layer.addAnimation(animation, forKey: nil)
    }
    // MARK: - 懒加载
    /// 背景图片
    private lazy var iconView:UIImageView = {
      let iv = UIImageView(image: UIImage(named: "visitordiscover_feed_image_smallicon"))
        
        return iv
    }()
    ///遮罩视图
    private lazy var maskIconView:UIImageView = {
        let iv = UIImageView(image: UIImage(named: "visitordiscover_feed_mask_smallicon"))
        
        return iv
    }()
    /// home图片
    private lazy var homeIconView:UIImageView = {
        let iv = UIImageView(image: UIImage(named: "visitordiscover_feed_image_house"))
        
        return iv
    }()
    //消息文字
    private lazy var messageLabel:UILabel = {
        let label = UILabel();
        label.text = "关注一些人，回这里看看有什么惊喜"
        label.font = UIFont.systemFontOfSize(14)
        label.textColor = UIColor.darkGrayColor()
        label.numberOfLines = 0;
        label.sizeToFit()
        return label
    }()
    /// 注册按钮
    private lazy var registerButton:UIButton = {
       let button = UIButton()
        button.setTitle("注册", forState: UIControlState.Normal)
        button.setTitleColor(UIColor.orangeColor(), forState:UIControlState.Normal )
        button.setBackgroundImage(UIImage(named: "common_button_white_disable"), forState: UIControlState.Normal)
        button.addTarget(self, action: "registerButtonClick", forControlEvents: UIControlEvents.TouchUpInside)
        return button
    }()
    /// 登录按钮
    private lazy var loginButton:UIButton = {
        let button = UIButton()
        button.setTitle("登录", forState: UIControlState.Normal)
        button.setTitleColor(UIColor.darkGrayColor(), forState:UIControlState.Normal )
        button.setBackgroundImage(UIImage(named: "common_button_white_disable"), forState: UIControlState.Normal)
        button.addTarget(self, action: "loginButtonClick", forControlEvents: UIControlEvents.TouchUpInside)
        return button
    }()
    
    private lazy var attentionButton:UIButton = {
        let button = UIButton()
        button.setTitle("去关注", forState: UIControlState.Normal)
        button.setTitleColor(UIColor.orangeColor(), forState:UIControlState.Normal )
        button.setBackgroundImage(UIImage(named: "common_button_white_disable"), forState: UIControlState.Normal)
        return button
    }()

}
