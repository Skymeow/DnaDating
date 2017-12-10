//
//  Networking.swift
//  Dndating
//
//  Created by Sky Xu on 12/9/17.
//  Copyright © 2017 Sky Xu. All rights reserved.
//

import Foundation

enum Route {
    case usersSignup
    case usersLogin
    case traits
    
    func path() -> String {
        switch self {
        case .usersSignup:
            return "new"
        case .usersLogin:
            return "login"
        case .traits:
            return "match"
        default:
            return ""
        }
    }
    
    func urlParameters() -> [String: String] {
        switch self {
        case .usersSignup:
            return [:]
        case .usersLogin:
            return [:]
        case .traits:
            return [:]
        }
    }
    
    func baseURl() -> String {
        switch self {
        case .usersSignup:
            return "https://dndate.herokuapp.com/user/"
        case .usersLogin:
            return "https://dndate.herokuapp.com/user/"
        case .traits:
            return "https://dndate.herokuapp.com/user/"
        default:
            return ""
        }
    }
    
    func body(data:Encodable?) -> Data? {
        switch self {
        case .usersSignup:
            let encoder = JSONEncoder()
            guard let user = data as? User else {return nil}
            let result = try? encoder.encode(user)
            return result
        case .usersLogin:
            let bodyData = try? JSONSerialization.data(withJSONObject: data)
            return bodyData
        case .traits:
            let encoder = JSONEncoder()
            guard let traits = data as? Trait else {return nil}
            let result = try? encoder.encode(traits)
            print(result)
            return result
        default:
            return nil
        }
    }
}

struct BasicAuth {
    static func generateBasicAuthHeader(username: String, password: String) -> String {
        let loginString = String(format: "%@:%@", username, password)
        let loginData: Data = loginString.data(using: String.Encoding.utf8)!
        let base64LoginString = loginData.base64EncodedString(options: .init(rawValue: 0))
        let authHeaderString = "Basic \(base64LoginString)"
        
        return authHeaderString
    }
}

class Networking {
    static let instance = Networking()
    let session = URLSession.shared
    
    func fetch(route: Route, method: String, headers: [String: String], data: Encodable?, completion: @escaping (Data, Int) -> Void) {
        var baseURL = route.baseURl()
        let urlString = baseURL.appending(route.path())
        var toURL = URL(string: urlString)!
        toURL = toURL.appendingQueryParameters(_parametersDictionary: route.urlParameters())
//        print(toURL)
        
        var request = URLRequest(url: toURL)
//        let bodyData = try? JSONSerialization.data(withJSONObject: data)
        request.httpBody = route.body(data: data)
        print(request.httpBody)
        request.allHTTPHeaderFields = headers
        request.httpMethod = method
        
        session.dataTask(with: request) { (data, response, error) in
            
            guard let responseCode = response as? HTTPURLResponse else {return}
            let statusCode = responseCode.statusCode
            guard let data = data else { return }
            print(data)
//            let parsedData = try? JSONSerialization.jsonObject(with: request.httpBody!, options: .allowFragments)
//            print(parsedData)
            completion(data, statusCode)
            }.resume()
    }
}

protocol URLQueryParameterStringConvertible {
    var queryParameters: String { get }
}

extension Dictionary: URLQueryParameterStringConvertible {
    var queryParameters: String {
        var parts: [String] = []
        for (key, value) in self {
            let part = String(format: "%@=%@", String(describing: key).addingPercentEncoding(withAllowedCharacters: .urlQueryAllowed)!,
                              String(describing: value).addingPercentEncoding(withAllowedCharacters: .urlQueryAllowed)!)
            parts.append(part as String)
        }
        return parts.joined(separator: "&")
    }
}

extension URL {
    func appendingQueryParameters(_parametersDictionary: Dictionary<String, String>) -> URL {
        let URLString: String = String(format: "%@?%@", self.absoluteString, _parametersDictionary.queryParameters)
        return URL(string: URLString)!
    }
}

