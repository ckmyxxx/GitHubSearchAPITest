//
//  String+EX.swift
//  GitHubSearch
//
//  Created by Huang YenHan on 2019/6/5.
//  Copyright © 2019 HuangYenHan. All rights reserved.
//

import Foundation

extension String {
    
    func checkNextPage() -> Bool {
        
        return self.contains("rel=\"next\"")
        
    }
    
}
