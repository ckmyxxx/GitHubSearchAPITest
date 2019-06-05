//
//  AuthorModel.swift
//  GitHubSearch
//
//  Created by Huang YenHan on 2019/6/3.
//  Copyright © 2019 HuangYenHan. All rights reserved.
//

import Foundation


struct UserModel: Codable {
    let totalCount: Int
    let results: Bool
    let items: [Items]
    var next: Bool?
    
    enum CodingKeys: String, CodingKey {
        case totalCount = "total_count"
        case results = "incomplete_results"
        case items
        case next
    }
}

struct Items: Codable {
    let login: String
    let id: Int
    let nodeId: String
    let avatarUrl: String
    let url: String
    let htmlUrl: String
    let score: Double
    
    enum CodingKeys: String, CodingKey {
        case login
        case id
        case nodeId = "node_id"
        case avatarUrl = "avatar_url"
        case url
        case htmlUrl = "html_url"
        case score
    }

    
}
