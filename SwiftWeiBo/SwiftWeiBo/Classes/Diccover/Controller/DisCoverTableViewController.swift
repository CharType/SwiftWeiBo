//
//  DisCoverTableViewController.swift
//  SwiftWeiBo
//
//  Created by 程倩 on 16/1/28.
//  Copyright © 2016年 CQ. All rights reserved.
//

import UIKit
class DisCoverTableViewController: BaseTableViewController {
    override func viewDidLoad() {
        super.viewDidLoad()
        
        if !userlogin {
          visitorView?.setupVisitorInfo(false, imageName: "visitordiscover_image_message", message: "登录后，最新、最热微博尽在掌握，不再会与实事潮流擦肩而过")
        }
        

    }
}
