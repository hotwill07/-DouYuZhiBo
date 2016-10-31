//
//  MainViewController.swift
//  DYZB
//
//  Created by xuwei on 16/9/22.
//  Copyright © 2016年 xuwei. All rights reserved.
//

import UIKit

/// 增加点注释
class MainViewController: UITabBarController {

    override func viewDidLoad() {
        super.viewDidLoad()
        
        addChildVC(storyName: "Home")
        addChildVC(storyName: "Live")
        addChildVC(storyName: "Follow")
        addChildVC(storyName: "Profile")
    }
    
    private func addChildVC(storyName: String) {
        //1.通过storyboard获取控制器
        let childVc = UIStoryboard(name: storyName, bundle: nil).instantiateInitialViewController()!
        
        //2.将childVc添加到tabbarVC
        addChildViewController(childVc)
    }
    
    
}


