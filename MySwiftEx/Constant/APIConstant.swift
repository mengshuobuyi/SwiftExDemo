//
//  APIConstant.swift
//  MySwiftEx
//
//  Created by codyy on 2016/10/18.
//  Copyright © 2016年 zpx. All rights reserved.
//

import Foundation
import Moya

public enum APIConstant {
    public enum HomepageCase {
        case TabOne
        case TabTwo
    }
    case HomePage(HomepageCase)
    case Profile
  
}

extension APIConstant:TargetType {
    public var baseURL: URL {
    
        return URL(string:" ")!
    }
    public var path: String {
        switch self {
        case let .HomePage(casee):
            switch casee {
            case .TabOne:
                return "TabOne"
            case .TabTwo:
                return "TabTwo"
            }
        default:
            return " "
        }
    }
    public var method: Moya.Method { return .GET }
    public var parameters: [String: Any]? { return nil }
    public var sampleData: Data { return "{}".data(using: String.Encoding.utf8)! }
    public var task: Moya.Task { 
        return .request
    }
}
