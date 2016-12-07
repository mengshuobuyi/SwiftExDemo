//
//  StoryboardExtension.swift
//  MySwiftEx
//
//  Created by codyy on 2016/12/6.
//  Copyright © 2016年 zpx. All rights reserved.
//

import Foundation
import UIKit
extension UIStoryboard {
    enum Storyboard: String {
        case Main
        case News
        case Profile
    }
    //便利构造方法 let storyboard = UIStoryboard(storyboard: .News)
    convenience init(_ storyboard: Storyboard, bundle: Bundle? = nil) {
        self.init(name: storyboard.rawValue, bundle: bundle)
    }
    // let storyboard = UIStoryboard.storyboard(storyboard: .News)
    class func storyboard(_ storyboard:Storyboard, bundle: Bundle? = nil)->UIStoryboard {
        return UIStoryboard(name: storyboard.rawValue, bundle: bundle)
    }
    func instantViewController<instantViewController:UIViewController>()->instantViewController where instantViewController: StoryboardIdentifiable {
        let viewController = self.instantiateViewController(withIdentifier: instantViewController.storyboardIdentifier)
        guard let vc = viewController as? instantViewController else {
            fatalError("could't instantiate view controller with identifier")
        }
        return vc
    }
}

protocol StoryboardIdentifiable {
    static var storyboardIdentifier: String { get }
}
//extension StoryboardIdentifiable where Self: UIViewController {
//    static var storyboardIdentifier: String {
//        return String(describing: self)
//    }
//}
extension UIViewController: StoryboardIdentifiable {
    static var storyboardIdentifier: String {
        return String(describing: self)
    }
}

