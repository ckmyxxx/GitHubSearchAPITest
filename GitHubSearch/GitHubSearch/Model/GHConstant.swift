//
//  GHConstant.swift
//  GitHubSearch
//
//  Created by Huang YenHan on 2019/6/4.
//  Copyright © 2019 HuangYenHan. All rights reserved.
//

import Foundation

struct GHConstant {
    
    static let urlKey = "GitHubSearchBaseUrl"
    
}

protocol GHRequest {
    
    var headers: [String: String] { get }
    
    var para: [URLQueryItem] { get }
    
    var body: [String: Any]? { get }
    
    var method: String { get }
    
    var endPoint: String { get }
    
}

enum GHSearchRequest: GHRequest {
    
    case searchUser(String, String)
    
    var headers: [String : String] {
        switch self {
        case .searchUser:
            return [:]
        }
    }
    
    var para: [URLQueryItem] {
        switch self {
        case .searchUser(let user, let page):
            return [URLQueryItem(name: "q", value: user), URLQueryItem(name: "page", value: page)]
        }
    }
    
    var body: [String: Any]? {
        switch self {
        case .searchUser:
            return nil
        }
    }
    
    var method: String {
        switch self {
        case .searchUser:
            return GHMethod.get.rawValue
        }
    }
    
    var endPoint: String {
        switch self {
        case .searchUser:
            return GHEndpoint.user.rawValue
        }
    }
    
}

enum GHMethod: String {
    case get = "GET"
}

enum GHEndpoint: String {
    case user = "/search/users"
}
