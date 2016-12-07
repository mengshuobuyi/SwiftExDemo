//
//  BYNavigationController.swift
//  MySwiftEx
//
//  Created by codyy on 2016/10/24.
//  Copyright © 2016年 zpx. All rights reserved.
//

import UIKit
import Foundation
class BYNavigationController: UINavigationController,UIGestureRecognizerDelegate,UINavigationControllerDelegate {

    override func viewDidLoad() {
        super.viewDidLoad()
        delegate = self
        interactivePopGestureRecognizer?.delegate = self
    }

    override func pushViewController(_ viewController: UIViewController, animated: Bool) {
        if animated {
            interactivePopGestureRecognizer?.isEnabled = false
        }
        super.pushViewController(viewController, animated: animated)
    }
    
    override func popToRootViewController(animated: Bool) -> [UIViewController]? {
        if animated {
            interactivePopGestureRecognizer?.isEnabled = false
        }
        return super.popToRootViewController(animated: animated)
    }
    
    override func popToViewController(_ viewController: UIViewController, animated: Bool) -> [UIViewController]? {
        if animated {
            interactivePopGestureRecognizer?.isEnabled = false
        }
        return super.popToViewController(viewController, animated: animated)
    }
    
    func navigationController(_ navigationController: UINavigationController, didShow viewController: UIViewController, animated: Bool) {
        interactivePopGestureRecognizer?.isEnabled = true
    }
    
    func gestureRecognizerShouldBegin(_ gestureRecognizer: UIGestureRecognizer) -> Bool {
        if self.viewControllers.count < 2 || self.visibleViewController === self.viewControllers[0] {
            return false
        }
        return true
    }
}
