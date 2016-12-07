//
//  BYTabBarViewController.swift
//  MySwiftEx
//
//  Created by codyy on 2016/10/21.
//  Copyright © 2016年 zpx. All rights reserved.
//

import UIKit
enum Tab:Int {
    case HomePage
    case ShoppingCart
    case Profile
    
    var title :String {
        switch self {
        case .HomePage:
            return "首页"
        case .ShoppingCart:
            return "购物车"
        case .Profile:
            return "个人中心"
        default:
            return "undefined"
        }
    }
}

final class BYTabBarViewController: UITabBarController {
    //设置当前selected Tab
    var tab : Tab? {
        didSet {
            if let tab = tab {
                self.selectedIndex = tab.rawValue
            }
        }
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        delegate = self
        view.backgroundColor = UIColor.white
        justTab()
    }
}



extension BYTabBarViewController:UITabBarControllerDelegate {
    func tabBarController(_ tabBarController: UITabBarController, shouldSelect viewController: UIViewController) -> Bool {
        return true
    }
    
    func tabBarController(_ tabBarController: UITabBarController, didSelect viewController: UIViewController) {
        
    }
}

extension BYTabBarViewController {
    fileprivate func justTab() {
        if let items = tabBar.items {
            for i in 0..<items.count {
                let item = items[i]
                item.title = Tab(rawValue: i)?.title
            }
        }
    }
}
