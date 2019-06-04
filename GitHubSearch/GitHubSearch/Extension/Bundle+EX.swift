//
//  Bundle+EX.swift
//  GitHubSearch
//
//  Created by Huang YenHan on 2019/6/4.
//  Copyright © 2019 HuangYenHan. All rights reserved.
//

import Foundation

extension Bundle {
    
    static func GHValueForString(key: String) -> String {
        
        return Bundle.main.infoDictionary![key] as! String
    }

}
