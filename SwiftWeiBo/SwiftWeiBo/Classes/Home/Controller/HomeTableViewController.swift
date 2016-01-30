//
//  HomeTableViewController.swift
//  SwiftWeiBo
//
//  Created by 程倩 on 16/1/28.
//  Copyright © 2016年 CQ. All rights reserved.
//

import UIKit

class HomeTableViewController: BaseTableViewController {
    override func viewDidLoad() {
        super.viewDidLoad()
        visitorView?.setupVisitorInfo(true, imageName: "visitordiscover_feed_image_house", message: "关注一些人，回这里看看有什么惊喜")
    }
}
