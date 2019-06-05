//
//  UIActivityIndicatorView+EX.swift
//  GitHubSearch
//
//  Created by Huang YenHan on 2019/6/5.
//  Copyright © 2019 HuangYenHan. All rights reserved.
//

import Foundation
import UIKit

extension UIActivityIndicatorView {
    
    func startLoad() {
        
        guard Thread.isMainThread == true else {
            
            DispatchQueue.main.async { [weak self] in
                
                self?.startAnimating()
            }
            
            return
        }
        
        startAnimating()
    }
    
    func stopLoad() {
        
        guard Thread.isMainThread == true else {
            
            DispatchQueue.main.async { [weak self] in
                
                self?.stopAnimating()
            }
            
            return
        }
        
        stopAnimating()
        
    }
    
}
