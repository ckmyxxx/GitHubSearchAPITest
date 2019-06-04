//
//  CollectionView+EX.swift
//  GitHubSearch
//
//  Created by Huang YenHan on 2019/6/3.
//  Copyright © 2019 HuangYenHan. All rights reserved.
//

import Foundation
import UIKit

extension UICollectionView {
    
    func yh_registerCellFromNib(_ identifier: String, bundle: Bundle? = nil) {
        
        let nib = UINib(nibName: identifier, bundle: bundle)
        
        register(nib, forCellWithReuseIdentifier: identifier)
    }
}
