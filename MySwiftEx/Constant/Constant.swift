//
//  Constant.swift
//  MySwiftEx
//
//  Created by codyy on 2016/10/21.
//  Copyright © 2016年 zpx. All rights reserved.
//

import Foundation
import UIKit
struct Constant {
    static let SCREEN_WIDTH:CGFloat = UIScreen.main.bounds.size.width
    static let SCREEN_HEIGHT:CGFloat = UIScreen.main.bounds.size.height
    // 导航栏高度
    static let UI_NAV_HEIGHT : CGFloat = 64
    // tab高度
    static let UI_TAB_HEIGHT : CGFloat = 49
    // 字体
    static let UI_FONT_12 : UIFont = UIFont.systemFont(ofSize: 12)
    static let UI_FONT_13 : UIFont = UIFont.systemFont(ofSize: 13)
    static let UI_FONT_14 : UIFont = UIFont.systemFont(ofSize: 14)
    static let UI_FONT_16 : UIFont = UIFont.systemFont(ofSize: 16)
    static let UI_FONT_20 : UIFont = UIFont.systemFont(ofSize: 20)
    static let UI_FONT_22 : UIFont = UIFont.systemFont(ofSize: 22)
    static let APPDELEGATE = UIApplication.shared.delegate as! AppDelegate
}
