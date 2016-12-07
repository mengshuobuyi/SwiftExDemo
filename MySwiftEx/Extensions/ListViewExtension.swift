//
//  ListViewExtension.swift
//  MySwiftEx
//
//  Created by codyy on 2016/12/5.
//  Copyright © 2016年 zpx. All rights reserved.
//

import Foundation
import UIKit
//return string describtion the name of class
protocol ReusableView: class {
    static var defaultIdentifier: String {get}
}

extension ReusableView where Self: UIView {
    static var defaultIdentifier: String {
        return String(describing: self)
    }
}

extension UITableViewCell: ReusableView {

}

extension UICollectionViewCell: ReusableView {

}

protocol NibLoadbleView: class {
    static var nibName: String {get}
}

extension NibLoadbleView where Self: UIView {
    static var nibName: String {
        return String(describing: self)
    }
}

extension UIView: NibLoadbleView {

}

//protocol ListViewProtocol {
////    associatedtype T
//    func register<T>(_: T.Type) where T:ReusableView
//    func register<T>(_: T.Type) where T:ReusableView, T: NibLoadbleView
//    
//}
//
//extension ListViewProtocol where Self: UITableView or UICollectionView {
////    typealias T = UITableViewCell
//    func register<T>(_: T.Type) where T: ReusableView {
//        register(T.self, forCellReuseIdentifier: T.defaultIdentifier)
//    }
//}
extension UITableView {
    func register<T: UITableViewCell>(_: T.Type) where T: ReusableView {
        register(T.self, forCellReuseIdentifier: T.defaultIdentifier)
    }
    func register<T: UITableViewCell>(_: T.Type) where T: ReusableView,T: NibLoadbleView {
        register(UINib(nibName:T.nibName,bundle:nil), forCellReuseIdentifier: T.defaultIdentifier)
    }
    func dequeueReusableCell<T: UITableViewCell>(forIndexPath indexPath: IndexPath)->T where T: ReusableView {
        guard let cell = dequeueReusableCell(withIdentifier: T.defaultIdentifier, for: indexPath) as? T else {
            fatalError("could not dequeue cell with \(T.defaultIdentifier)")
        }
        return cell
    }
}

extension UICollectionView {
    func register<T: UICollectionViewCell>(_: T.Type) where T: ReusableView {
        register(T.self, forCellWithReuseIdentifier: T.defaultIdentifier)
    }
    func register<T: UICollectionViewCell>(_: T.Type) where T: ReusableView,T: NibLoadbleView {
        register(UINib(nibName:T.nibName,bundle:nil), forCellWithReuseIdentifier: T.defaultIdentifier)
    }
    func dequeueReusableCell<T: UICollectionViewCell>(withIndexPath indexPath: IndexPath)->T where T: ReusableView {
        guard let cell = dequeueReusableCell(withReuseIdentifier: T.defaultIdentifier, for: indexPath) as? T else {
            fatalError("could not dequeue cell with \(T.defaultIdentifier)")
        }
        return cell
    }
}
