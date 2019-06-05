//
//  AlamofireWrapper.swift
//  GitHubSearch
//
//  Created by Huang YenHan on 2019/6/5.
//  Copyright © 2019 HuangYenHan. All rights reserved.
//

import Foundation
import Alamofire

class GHHTTP {
    
    static func YHRequestWCookie(_ url: String, para: [String: String]? = nil) -> DataRequest {
        
        return Alamofire.request(
            url,
            method: .get,
            parameters: para,
            encoding: URLEncoding.default,
            headers: HTTPHeaders(dictionaryLiteral: ("Cookie", "over18=1")))
        
    }
}
