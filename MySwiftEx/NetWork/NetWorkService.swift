//
//  NetWorkService.swift
//  MySwiftEx
//
//  Created by codyy on 2016/10/18.
//  Copyright © 2016年 zpx. All rights reserved.
//

import Foundation
import Moya

class NetService {
    static let shareInstance = NetService()
    let NWProvider = MoyaProvider<APIConstant>()
    fileprivate init(){}
    
    func getData<T:Initable>(_ target:APIConstant,keys:Array<String>,successHandle:((Array<T>) -> Void)?, errorHandle:((Moya.Error) -> Void)?) {
        //处理数据函数
        func dealWithData(_ content:Array<AnyObject>) {
            //异步处理数据
            DispatchQueue.global().async { 
                let modelArray = content.map({ (dict) -> T in
                    return T(dict: dict as! NSDictionary)
                })
                //主线程返回数据
                DispatchQueue.main.async(execute: { 
                    if let success = successHandle {
                        success(modelArray)
                    }
                })
            }
        }
        
        NWProvider.request(target) { (result) in
            switch result {
            case let .success(response):
                do {
                    let json = try response.mapJSON() as? Dictionary<String,AnyObject>
                    if let json = json {
                        //获取data数组
                        if keys.count == 1 {
                            if let content = json[keys[0]] as? Array<AnyObject> {
                                dealWithData(content)
                            }else {
                                //没有数据
                            }
                        } else if keys.count == 2 {
                            if let content = json[keys[0]] as? Dictionary<String, AnyObject> {
                                if let alls = (content[keys[1]] as? Array<AnyObject>) {
                                    dealWithData(alls)
                                }
                            } else {
                                //没有数据
                            }
                        }
                        
                    } else {
                        //没有数据
                    }
                } catch {
                    //异常
                }
            case let .failure(error):
                if let handle = errorHandle {
                    handle(error)
                }
            }
        }
        
        
    }
    
}
