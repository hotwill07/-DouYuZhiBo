//
//  RecommandViewController.swift
//  DYZB
//
//  Created by xuwei on 16/9/26.
//  Copyright © 2016年 xuwei. All rights reserved.
//

import UIKit

fileprivate let kItemMargin: CGFloat = 10
fileprivate let kItemW = (kScreenW - 3 * kItemMargin) / 2
fileprivate let kItemH = kItemW * 3 / 4
fileprivate let kHeaderViewH: CGFloat = 50
fileprivate let kNormalCellID = "kNormalCellID"
fileprivate let kHeaderViewID = "kHeaderViewID"

class RecommandViewController: UIViewController {
    //MARK: 懒加载
    fileprivate lazy var collectionView: UICollectionView = { [unowned self] in
        //1. 创建布局
        let layout = UICollectionViewFlowLayout()
        layout.itemSize = CGSize(width: kItemW, height: kItemH)
        layout.minimumLineSpacing = 0   // 行间距
        layout.minimumInteritemSpacing = kItemMargin // item之间的间距
        //设置组头的size
        layout.headerReferenceSize = CGSize(width: kScreenW, height: kHeaderViewH)
        //设置组头的内边距
        layout.sectionInset = UIEdgeInsets(top: 0, left: kItemMargin, bottom: 0, right: kItemMargin)
        
        //2. 创建collectionView
        let collectionView = UICollectionView(frame: self.view.bounds, collectionViewLayout: layout)
        collectionView.backgroundColor = UIColor.white
        collectionView.dataSource = self
        
        // 按照屏幕的比率缩放
//        collectionView.autoresizingMask = [.flexibleHeight , .flexibleWidth]
        collectionView.autoresizingMask = [.flexibleWidth, .flexibleHeight]
        // 注册cell
        collectionView.register(UICollectionViewCell.self, forCellWithReuseIdentifier: kNormalCellID)
        
        // 注册组头
//        collectionView.register(UICollectionReusableView.self, forSupplementaryViewOfKind:UICollectionElementKindSectionHeader , withReuseIdentifier: kHeaderViewID)
        collectionView.register(UINib(nibName: "CollectionHeaderView", bundle: nil), forSupplementaryViewOfKind: UICollectionElementKindSectionHeader, withReuseIdentifier: kHeaderViewID)
        
        //3. 返回
        return collectionView
    }()
    
    //MARK: 系统回调函数
    override func viewDidLoad() {
        super.viewDidLoad()

        //设置UI界面
        setupUI()
        
       
    }

}

//MARK: 设置UI界面
extension RecommandViewController {
    fileprivate func setupUI() {
        view.addSubview(collectionView)
    }
}

//MARK: 遵守UICollectionView的数据源协议
extension RecommandViewController: UICollectionViewDataSource {
    func numberOfSections(in collectionView: UICollectionView) -> Int {
        return 12
    }
    
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        if section == 0 {
            return 8
        }
        return 4
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        //1. 获取cell
        let cell = collectionView.dequeueReusableCell(withReuseIdentifier:kNormalCellID, for: indexPath)
        cell.backgroundColor = .red
        return cell
    }
    
    func collectionView(_ collectionView: UICollectionView, viewForSupplementaryElementOfKind kind: String, at indexPath: IndexPath) -> UICollectionReusableView {
        //1. 出去setion的headerView
        let headerView = collectionView.dequeueReusableSupplementaryView(ofKind: kind, withReuseIdentifier: kHeaderViewID, for: indexPath)
                
        return headerView
    }
    
    
}


