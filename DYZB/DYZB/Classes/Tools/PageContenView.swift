//
//  PageContenView.swift
//  DYZB
//
//  Created by xuwei on 16/9/22.
//  Copyright © 2016年 xuwei. All rights reserved.
//

import UIKit
protocol PageContenViewDelegate: class {
    func pageContentView(contentView: PageContenView, progress: CGFloat, sourceIndex: Int, targetIndex: Int)
}

fileprivate let ContentCellID = "ContentCellID"

class PageContenView: UIView {
    
    // MARK:- 自定义属性
    fileprivate var childVcs: [UIViewController]
    fileprivate weak var parentViewController: UIViewController?
    fileprivate var startOffsetX: CGFloat = 0
    weak var delegate: PageContenViewDelegate?
    fileprivate var isForbidScrollDelegate: Bool = false
    
    // MARK:- 懒加载
    fileprivate lazy var collectionView: UICollectionView = {[weak self] in
        // 闭包中也的self也可能出现循环引用 需要将self弱化
        
        //1. 创建layout
        let layout = UICollectionViewFlowLayout()
        layout.itemSize = (self?.bounds.size)!
        layout.minimumLineSpacing = 0
        layout.minimumInteritemSpacing = 0
        layout.scrollDirection = .horizontal
        
        //2. 创建UICollectionView
        let collectionView = UICollectionView(frame: .zero, collectionViewLayout: layout)
        collectionView.showsHorizontalScrollIndicator = false
        collectionView.isPagingEnabled = true
        collectionView.bounces = false
        collectionView.dataSource = self
        collectionView.delegate = self
        collectionView.register(UICollectionViewCell.self, forCellWithReuseIdentifier: ContentCellID)
        return collectionView
    }()
    
    // MARK:- 自定构造函数
    init(frame: CGRect, childVcs: [UIViewController], parentViewController: UIViewController?) {
        self.childVcs = childVcs
        self.parentViewController = parentViewController
        super.init(frame: frame)
        
        // 设置UI
        setupUI()
    }
    
    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
}


// MARK:- 设置UI界面
extension PageContenView {
    fileprivate func setupUI() {
        //1. 将所有的子控制器添加到父控制器中
        for childVc in childVcs {
            parentViewController?.addChildViewController(childVc)
        }
        
        //2. 添加UICollectionView，用于在Cell中存放控制器的View
        addSubview(collectionView)
        collectionView.frame = bounds
    }
}


// MARK:- 遵守UICollectionViewDataSource
extension PageContenView: UICollectionViewDataSource {
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return childVcs.count
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        //1. 创建cell
        let cell = collectionView.dequeueReusableCell(withReuseIdentifier: ContentCellID, for: indexPath)
        
        //2. 给cell设置内容
        for view in cell.contentView.subviews {
            view.removeFromSuperview()
        }
        
        let childVc = childVcs[indexPath.item]
        childVc.view.frame = cell.contentView.bounds
        cell.contentView.addSubview(childVc.view)
        
        return cell
    }
    
}

// MARK:- 遵守UICollectionViewDelegate
extension PageContenView: UICollectionViewDelegate {
    func scrollViewDidScroll(_ scrollView: UIScrollView) {
        //0. 判断是否是点击事件
        if isForbidScrollDelegate { return }
        
        //1. 获取需要的数据
        var progress: CGFloat = 0
        var sourceIndex: Int = 0
        var targetIndex: Int = 0
        
        //2. 判断是左滑还是右滑
        let currentOffsetX = scrollView.contentOffset.x
        let scrollViewW = scrollView.bounds.width
        if startOffsetX < currentOffsetX { // 左滑
            // 计算progress
            progress = currentOffsetX / scrollViewW - floor(currentOffsetX / scrollViewW)
            sourceIndex = Int(currentOffsetX / scrollViewW)
            targetIndex = sourceIndex + 1
            if targetIndex >= childVcs.count {
                targetIndex = childVcs.count - 1
            }
            
            // 完全划过去
            if currentOffsetX - startOffsetX == scrollViewW {
                progress = 1
                targetIndex = sourceIndex
            }
        } else {
            progress = 1 - (currentOffsetX / scrollViewW - floor(currentOffsetX / scrollViewW))
            targetIndex = Int(currentOffsetX / scrollViewW)
            sourceIndex = targetIndex + 1
            if sourceIndex >= childVcs.count {
                sourceIndex = childVcs.count - 1
            }
        }
        
        //3. 将数据传递给TitleView
        print("p:\(progress),source:\(sourceIndex),target:\(targetIndex))")
        
        delegate?.pageContentView(contentView: self, progress: progress, sourceIndex: sourceIndex, targetIndex: targetIndex)
    }
    
    // 开始拖动
    func scrollViewWillBeginDragging(_ scrollView: UIScrollView) {
        startOffsetX = scrollView.contentOffset.x
        
        // 滚动的时候 设置成false
        isForbidScrollDelegate = false
    }
}

// MARK:- 对外暴露的方法
extension PageContenView {
    func setCurrentIndex(currentIndex: Int) {
        //1.记录需要禁止执行代理方法
        isForbidScrollDelegate = true
        
        //2.滚动到正确的位置
        let offsetX = CGFloat(currentIndex) * collectionView.frame.width
        collectionView.setContentOffset(CGPoint.init(x: offsetX, y: 0), animated: false)
    }
}






