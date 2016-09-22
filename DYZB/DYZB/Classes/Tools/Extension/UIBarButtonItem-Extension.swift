//
//  UIBarButtonItem-Extension.swift
//  DYZB
//
//  Created by xuwei on 16/9/22.
//  Copyright © 2016年 xuwei. All rights reserved.
//

import UIKit

// 对UIBarButtonItem 进行扩展
extension UIBarButtonItem {
//    class func createItem(imageName: String, hilightedImageName: String, size: CGSize) -> UIBarButtonItem {
//        let btn = UIButton()
//        
//        btn.setImage(UIImage.init(named: imageName), for: .normal)
//        btn.setImage(UIImage.init(named: hilightedImageName), for: .highlighted)
//        btn.frame = CGRect(origin: .zero, size: size)
//        return UIBarButtonItem.init(customView: btn)
//    }
//    
    // 便利构造函数
    // 1> convenience 开头
    // 2> 在构造函数中必须调用一个已经设计好的构造函数(self)
    // 3> 默认参数
    convenience init(imageName: String, hilightedImageName: String = "", size: CGSize = .zero) {
        let btn = UIButton()
        
        btn.setImage(UIImage.init(named: imageName), for: .normal)
        if hilightedImageName != "" {
          btn.setImage(UIImage.init(named: hilightedImageName), for: .highlighted)
        }
        
        if size != .zero {
            btn.frame = CGRect(origin: .zero, size: size)
        } else {
            btn.sizeToFit()
        }
        
        self.init(customView: btn)
    }
}


