//
//  MessageTableViewController.swift
//  SwiftWeiBo
//
//  Created by 程倩 on 16/1/28.
//  Copyright © 2016年 CQ. All rights reserved.
//

import UIKit
class MessageTableViewController: BaseTableViewController {
    override func viewDidLoad() {
        super.viewDidLoad()
        visitorView?.setupVisitorInfo(false, imageName: "visitordiscover_image_message", message: "登录后，别人评论你的微博，发给你的消息，都会在这里收到通知")
    }
}
