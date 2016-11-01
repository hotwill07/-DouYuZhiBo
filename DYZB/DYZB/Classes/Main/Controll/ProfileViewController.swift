//
//  ProfileViewController.swift
//  DYZB
//
//  Created by xuwei on 2016/11/1.
//  Copyright © 2016年 xuwei. All rights reserved.
//

import UIKit

fileprivate let kPrivateCellID = "kPrivateCellID"

/// 个人VC
class ProfileViewController: UIViewController {

    lazy var tableView: UITableView = { [weak self] in
        let tableView = UITableView(frame: (self?.view.frame)!, style: .plain)
        tableView.delegate = self
        tableView.dataSource = self
        tableView.showsVerticalScrollIndicator = false
        tableView.showsHorizontalScrollIndicator = false
        
        tableView.register(UITableViewCell.self, forCellReuseIdentifier: kPrivateCellID)
        return tableView
        }()

    override func viewDidLoad() {
        super.viewDidLoad()
        self.title = "个人中心"
        self.view.addSubview(tableView)
        
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
    }
}


// MARK: - 代理方法.
extension ProfileViewController: UITableViewDelegate {
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        tableView .deselectRow(at: indexPath, animated: false)
        let alertView = UIAlertView(title: "点击事件", message: "您点击了第\(indexPath.row + 1)行", delegate: self, cancelButtonTitle: "取消", otherButtonTitles: "确定")
        alertView.show()
    }
}

// MARK: - 数据源方法.
extension ProfileViewController: UITableViewDataSource {
    func numberOfSections(in tableView: UITableView) -> Int {
        return 1
    }
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return 20
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
       let cell = tableView.dequeueReusableCell(withIdentifier: kPrivateCellID, for: indexPath)
        if indexPath.row % 2 == 0 {
            cell.backgroundColor = .gray
        } else {
            cell.backgroundColor = .red
        }
        cell.textLabel?.text = "row \(indexPath.row + 1)"
        cell.textLabel?.textColor = .white
        return cell
    }
    
}


// MARK: - UIAlertView代理方法.
extension ProfileViewController: UIAlertViewDelegate {
    func alertView(_ alertView: UIAlertView, clickedButtonAt buttonIndex: Int) {
        switch buttonIndex {
        case 0:
            print("点击了取消")
        default:
            print("点击了确定")
        }
    }
}


