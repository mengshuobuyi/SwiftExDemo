//
//  MVVMTest.swift
//  MySwiftEx
//
//  Created by codyy on 2016/12/6.
//  Copyright © 2016年 zpx. All rights reserved.
//

import Foundation
import UIKit
protocol ViewModelProtocol {
    associatedtype returnType: Layoutable
    associatedtype sourceType: Encodeable
    var sourceModel: sourceType {get}
    func dealBusness()->returnType    
}
protocol Encodeable {
    func parseWork()->Self?
}
extension Encodeable {
    func parseWork()->Self? {
        print("do nothing")
    }
}
//sourceModel
struct Message: Encodeable {
    var longStr: String
    var shortStr: String
}
extension UITableViewCell {
    func config<T>(withDelegate delegate:T) where T: ViewModelProtocol{
        let x = delegate.dealBusness()
        x.layoutCell(self)
    }
}
protocol Layoutable {
    func layoutCell(_ cell: UITableViewCell)
}
struct LayoutModel: Layoutable {
    var name: String
    var message: String
    func layoutCell(_ cell: UITableViewCell) {
        
    }
}
//viewModel
struct DealTest: ViewModelProtocol {
    typealias returnType = LayoutModel
    typealias sourceType = Message
    var sourceModel: sourceType
    init(_ sourceModel: sourceType) {
        self.sourceModel = sourceModel
    }
    func dealBusness() -> LayoutModel {
        return LayoutModel(name: sourceModel.longStr, message: sourceModel.shortStr)
    }
}
func test() {
    let cell = UITableViewCell()
    let mmm = DealTest(Message(longStr: "abcde", shortStr: "c"))
    cell.config(withDelegate: mmm)
}
