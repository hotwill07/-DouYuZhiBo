//
//  UIColor-Extension.swift
//  DYZB
//
//  Created by xuwei on 16/9/23.
//  Copyright © 2016年 xuwei. All rights reserved.
//

import UIKit

extension UIColor {
    convenience init(r: CGFloat, g: CGFloat, b: CGFloat) {
        self.init(red: r / 255.0, green: g / 255.0, blue: b / 255.0, alpha: 1.0)
    }
}
