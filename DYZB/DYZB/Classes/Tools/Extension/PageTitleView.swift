//
//  PageTitleView.swift
//  DYZB
//
//  Created by xuwei on 16/9/22.
//  Copyright © 2016年 xuwei. All rights reserved.
//

import UIKit

//:class 表示这个代理只能被 类遵守, 如果不写可能被结构体或者枚举类型遵守
protocol PageTitleViewDelegate: class {
    func pageTitleView(titleView: PageTitleView, selectedIndex index: Int)
}

private let kScrollLineH: CGFloat = 2

class PageTitleView: UIView {
    // MARK:- 定义属性
    fileprivate var titles: [String]
    // 定义一个下标值 保存当前的label
    fileprivate var currentIndex: Int = 0
    weak var delegate: PageTitleViewDelegate?
    
    
    // MARK:- 懒加载属性
    fileprivate lazy var scrollView: UIScrollView = {
        let scrollView = UIScrollView()
        scrollView.showsHorizontalScrollIndicator = false
        scrollView.scrollsToTop = false
        scrollView.bounces = false
        return scrollView
    }()
    
    fileprivate lazy var scrollLine: UIView = {
        let scrollLine = UIView()
        scrollLine.backgroundColor = UIColor.orange
        return scrollLine
    }()
    
    fileprivate lazy var titleLabels: [UILabel] = [UILabel]()
    
    // MARK:- 自定义构造函数
    init(frame: CGRect, titles: [String]) {
        self.titles = titles
        super.init(frame: frame)
        
        //设置UI界面
        setupUI()
    }
    
    // 重写自定义构造函数 该函数必须要写
    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
}

// MARK:- 设置UI界面
extension PageTitleView {
    fileprivate func setupUI() {
        //1. 添加scrollView
        addSubview(scrollView)
        scrollView.frame = bounds
        
        //2. 添加对应的label
        setupTitlesLabel()
        
        //3. 设置底部滚动的滑块
        setupBottomLineAndScrollLine()
    }
    
    private func setupTitlesLabel() {
        //0. 确定label的一些frame的值
        let labelW: CGFloat = frame.width / CGFloat(titles.count)
        let labelH: CGFloat = frame.height - kScrollLineH
        let labelY: CGFloat = 0
        
        for (index, title) in titles.enumerated() {
            //1. 创建UILabel
            let label = UILabel()
            
            //2. 设置label的属性
            label.text = title
            label.tag = index
            label.font = UIFont.systemFont(ofSize: 16.0)
            label.textColor = .darkGray
            label.textAlignment = .center
            
            //3. 设置frame
            let labelX:  CGFloat = labelW * CGFloat(index)
            label.frame = CGRect(x: labelX, y: labelY, width: labelW, height: labelH)
            
            //4. 添加到scrollView中
            scrollView.addSubview(label)
            
            //5. 添加到labels数组中
            titleLabels.append(label)
            
            //6. 给label添加手势
            label.isUserInteractionEnabled = true
            let tapGes = UITapGestureRecognizer(target: self, action: #selector(self.titleLabelClick(tapGes:)))
            label.addGestureRecognizer(tapGes)
        }
    }
    
    private func setupBottomLineAndScrollLine() {
        //1. 添加底线
        let bottomLine = UIView()
        bottomLine.backgroundColor = UIColor.lightGray
        let lineH: CGFloat = 0.5
        bottomLine.frame = CGRect(x: 0, y: frame.height - lineH, width: frame
            .width, height: lineH)
        addSubview(bottomLine)
        
        //2. 添加scrollLine
        
        //2.1 获取第一个label
        guard let firstLabel = titleLabels.first else {
            return
        }
        firstLabel.textColor = UIColor.orange
        //2.2 设置scrollLine 属性
        scrollView.addSubview(scrollLine)
        scrollLine.frame = CGRect(x: firstLabel.frame.origin.x, y: frame.height - kScrollLineH, width: firstLabel.frame.size.width, height: kScrollLineH)
    }
    
}

// MARK:- 监听label的点击事件
extension PageTitleView {
    @objc fileprivate func titleLabelClick(tapGes: UITapGestureRecognizer) {
        //1. 获取当前点击的label的下标值
        guard let currentLable = tapGes.view as? UILabel else {return}
        
        //2. 获取之前的label
        let oldLabel = titleLabels[currentIndex]
        
        //3. 切换文字的颜色
        currentLable.textColor = UIColor.orange
        oldLabel.textColor = UIColor.darkGray
        
        //4. 保存最新label的下标
        currentIndex = currentLable.tag
        
        //5. 滚动条位置发生改变
        let scrollLineX = CGFloat(currentIndex) * scrollLine.frame.width
        UIView.animate(withDuration: 0.15) { 
            self.scrollLine.frame.origin.x = scrollLineX
        }
        
        //6. 通知代理
        delegate?.pageTitleView(titleView: self, selectedIndex: currentIndex)
    }
}






