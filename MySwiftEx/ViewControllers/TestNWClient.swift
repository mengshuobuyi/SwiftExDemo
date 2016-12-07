//
//  TestNWClient.swift
//  MySwiftEx
//
//  Created by codyy on 2016/12/2.
//  Copyright © 2016年 zpx. All rights reserved.
//

import Foundation
import Alamofire
struct User {
    let name: String
    let message: String
    
    init?(data: Data) {
        guard let obj = try? JSONSerialization.jsonObject(with: data) as? [String: Any] else {
            return nil
        }
        guard let name = obj?["name"] as? String else {
            return nil
        }
        guard let message = obj?["message"] as? String else {
            return nil
        }
        self.name = name
        self.message = message
    }
}
extension User: Decodable {
    static func parse(data: Data) -> User? {
        return User(data: data)
    }
}
enum HTTPMethod: String {
    case GET
    case POST
}
protocol Request {
    associatedtype Response: Decodable
    var path: String {get}
    var method: HTTPMethod {get}
    var parameter: [String: Any] {get}
}
protocol Client {
    var host: String {get}
    func send<T: Request>(_ r: T, handler: @escaping (T.Response?) -> Void)
}
protocol Decodable {
    static func parse(data: Data) -> Self?
}
struct URLSessionClient: Client {
    static let clientt = URLSessionClient()
    let host = "https://api.onevcat.com"
    
    func send<T : Request>(_ r: T, handler: @escaping (T.Response?) -> Void) {
        let url = URL(string: host.appending(r.path))!
        var request = URLRequest(url: url)
        request.httpMethod = r.method.rawValue
        
        let task = URLSession.shared.dataTask(with: request) { (data, _, error) in
            if let data = data, let res = T.Response.parse(data: data) {
                DispatchQueue.main.async {
                    handler(res)
                }
            }else {
                DispatchQueue.main.async {
                    handler(nil)
                }
            }
        }
        task.resume()
    }
}
struct UserRequest: Request {
    typealias Response = User
    let name: String
    var path: String {
        return "/users/\(name)"
    }
    let method: HTTPMethod = .GET
    let parameter: [String: Any] = [:]
}

func test() {
    URLSessionClient.clientt.send(UserRequest(name: "onevcat")) { (<#T.Response?#>) in
        
    }
}




