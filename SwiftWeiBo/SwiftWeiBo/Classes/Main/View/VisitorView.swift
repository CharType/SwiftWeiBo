//
//  VisitorView.swift
//  SwiftWeiBo
//
//  Created by 程倩 on 16/1/29.
//  Copyright © 2016年 CQ. All rights reserved.
//

import UIKit

class VisitorView: UIView {

    override init(frame: CGRect) {
        super.init(frame: frame)
        
        setUI()
    }
    
    private func  setUI(){
       //添加控件
        addSubview(iconView)
        addSubview(maskIconView)
        addSubview(homeIconView)
        addSubview(messageLabel)
        addSubview(registerButton)
        addSubview(loginButton)
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
    }

    // 必须重写这个方法, Swift推荐我们要么支持纯代码, 要么支持XIB
    // 这样可以简化代码的复杂度
    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
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
        return button
    }()
    /// 登录按钮
    private lazy var loginButton:UIButton = {
        let button = UIButton()
        button.setTitle("登录", forState: UIControlState.Normal)
        button.setTitleColor(UIColor.orangeColor(), forState:UIControlState.Normal )
        button.setBackgroundImage(UIImage(named: "common_button_white_disable"), forState: UIControlState.Normal)
        return button
    }()

}
