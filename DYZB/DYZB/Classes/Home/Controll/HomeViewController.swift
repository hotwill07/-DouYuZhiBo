//
//  HomeViewController.swift
//  DYZB
//
//  Created by xuwei on 16/9/22.
//  Copyright © 2016年 xuwei. All rights reserved.
//

import UIKit

private let kTitleViewH: CGFloat = 40

class HomeViewController: UIViewController {
    
    // MARK:- 懒加载属性
    fileprivate lazy var pageTitleView: PageTitleView = {[weak self] in
        let titleFrame = CGRect(x: 0, y: kStatusBarH + kNavigationBarH, width: kScreenW, height: kTitleViewH)
        
        let titles = ["推荐", "游戏", "娱乐", "趣玩"]
        
        let titleView = PageTitleView(frame: titleFrame, titles: titles)
        titleView.delegate = self
        return titleView
    }()
    
    fileprivate lazy var pageContentView: PageContenView = {[weak self] in
        let contentH = kScreenH - (kStatusBarH + kNavigationBarH + kTitleViewH)
        let contentFrame = CGRect(x: 0, y: kStatusBarH + kNavigationBarH + kTitleViewH, width: kScreenW, height: contentH)
        
        // 确定所有的子控制器
        var childVc = [UIViewController]()
        for _ in 0..<4 {
            let vc = UIViewController()
            vc.view.backgroundColor = UIColor(r: CGFloat(arc4random_uniform(255)), g: CGFloat(arc4random_uniform(255)), b: CGFloat(arc4random_uniform(255)))
            childVc.append(vc)
        }
        
        let pageContentView = PageContenView(frame: contentFrame, childVcs: childVc, parentViewController: self)
        return pageContentView
    }()
    
    // MARK:- 系统回调函数
    override func viewDidLoad() {
        super.viewDidLoad()
        
        // 设置UI界面
        setupUI()
        
    }
}

// MARK:- 设置UI界面
extension HomeViewController {
   fileprivate func setupUI() {
        //0 不需要调整UIScrollView的内边距
        automaticallyAdjustsScrollViewInsets = false
        
        //1 设置导航栏
        setupNavigationBar()
        
        //2 添加titleView
        view.addSubview(pageTitleView)
    
        //3 添加contentView
        view.addSubview(pageContentView)
        pageContentView.backgroundColor = .purple
        
    }
    
    // 设置导航栏
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

// MARK:- 遵守协议
extension HomeViewController: PageTitleViewDelegate {
    func pageTitleView(titleView: PageTitleView, selectedIndex index: Int) {
        pageContentView.setCurrentIndex(currentIndex: index)
    }
}









