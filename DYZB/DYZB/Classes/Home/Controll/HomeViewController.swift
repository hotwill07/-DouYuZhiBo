//
//  HomeViewController.swift
//  DYZB
//
//  Created by xuwei on 16/9/22.
//  Copyright © 2016年 xuwei. All rights reserved.
//

import UIKit

class HomeViewController: UIViewController {

    override func viewDidLoad() {
        super.viewDidLoad()
        
        // 设置UI界面
        setupUI()
    }
}

// MARK:- 设置UI界面
extension HomeViewController {
    func setupUI() {
        setupNavigationBar()
    }
    
    private func setupNavigationBar() {
        // 1.设置左侧的按钮
        navigationItem.leftBarButtonItem = UIBarButtonItem(imageName: "logo")
        
        // 2.右侧的按钮
        let size = CGSize(width: 40, height: 40)
        let historyItem = UIBarButtonItem(imageName: "image_my_history", hilightedImageName: "Image_my_history_click", size: size)
        
        let searchItem = UIBarButtonItem(imageName:  "btn_search", hilightedImageName: "btn_search_clicked", size: size)
        
        let qrcodeItem = UIBarButtonItem(imageName: "Image_scan", hilightedImageName: "Image_scan_click", size: size)
        
        navigationItem.rightBarButtonItems = [historyItem, searchItem, qrcodeItem]
        
    }
}




