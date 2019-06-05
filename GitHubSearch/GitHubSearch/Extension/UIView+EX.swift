//
//  UIView+EX.swift
//  GitHubSearch
//
//  Created by Huang YenHan on 2019/6/5.
//  Copyright © 2019 HuangYenHan. All rights reserved.
//

import Foundation
import UIKit

extension UIView {
    
    func hidden(_ bool: Bool) {
        
        guard Thread.isMainThread == true else {
            
            DispatchQueue.main.async { [weak self] in
                
                self?.isHidden = bool
            }
            
            return
        }
        
        isHidden = bool
    }
}
